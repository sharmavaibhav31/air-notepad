import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'hand_tracker.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'dart:async';

class CameraScreen extends StatefulWidget {
  final HandTracker handTracker;

  const CameraScreen({super.key, required this.handTracker});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _controller = CameraController(cameras![0], ResolutionPreset.medium, enableAudio: false);
      await _controller!.initialize();
      setState(() {});

      // Start processing frames
      _controller!.startImageStream((CameraImage image) {
        if (!isProcessing) {
          isProcessing = true;
          processFrame(image).then((_) {
            isProcessing = false;
          });
        }
      });
    }
  }

  Future<void> processFrame(CameraImage image) async {
    try {
      // Convert CameraImage to Uint8List
      Uint8List imageData = _convertCameraImageToUint8List(image);

      // Run hand detection
      var result = await widget.handTracker.detectHand(imageData);
      print("🤖 Hand Landmarks: $result");
    } catch (e) {
      print("⚠️ Error processing frame: $e");
    }
  }

  Uint8List _convertCameraImageToUint8List(CameraImage image) {
    // Convert YUV420 camera image to RGB (basic approach)
    img.Image imgFrame = img.Image(image.width, image.height);

    final int yRowStride = image.planes[0].bytesPerRow;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel!;

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final int uvIndex = uvPixelStride * (x ~/ 2) + uvRowStride * (y ~/ 2);
        final int index = y * yRowStride + x;

        final int yValue = image.planes[0].bytes[index];
        final int uValue = image.planes[1].bytes[uvIndex];
        final int vValue = image.planes[2].bytes[uvIndex];

        int r = (yValue + 1.370705 * (vValue - 128)).toInt();
        int g = (yValue - 0.698001 * (vValue - 128) - 0.337633 * (uValue - 128)).toInt();
        int b = (yValue + 1.732446 * (uValue - 128)).toInt();

        imgFrame.setPixel(x, y, img.getColor(
          r.clamp(0, 255), g.clamp(0, 255), b.clamp(0, 255),
        ));
      }
    }

    return Uint8List.fromList(img.encodeJpg(imgFrame));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera View')),
      body: _controller == null || !_controller!.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : CameraPreview(_controller!),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
