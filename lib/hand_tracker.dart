import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart'; // Import rootBundle

class HandTracker {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    try {
      String modelPath = 'assets/models/hand_landmarks_detector.tflite';

      // Verify asset exists
      ByteData data = await rootBundle.load(modelPath);
      print("✅ Asset exists and loaded: ${data.lengthInBytes} bytes");

      _interpreter = await Interpreter.fromAsset(modelPath);
      print("✅ Hand Landmarker model loaded!");
    } catch (e) {
      print("❌ Failed to load model: $e");
    }
  }

  Interpreter? get interpreter => _interpreter; // ✅ ADDED GETTER
  Future<List<List<List<double>>>> detectHand(Uint8List imageData) async {
    try {
      // Decode image
      img.Image? image = img.decodeImage(imageData);
      if (image == null) {
        print("⚠️ Failed to decode image.");
        return [];
      }

      // Resize image to 224x224 (adjust to match model's expected input size)
      img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

      // Convert image to Float32 format for TensorFlow Lite
      var input = _imageToByteListFloat32(resizedImage, 224, 224);

      // Prepare output array
      var output = List.generate(1, (i) => List.generate(21, (j) => List.filled(3, 0.0)));

      _interpreter.run(input, output);
      print("🤖 Hand Landmarks Detected: $output");

      return output;
    } catch (e) {
      print("⚠️ Error running hand detection: $e");
      return [];
    }
  }

  Uint8List _imageToByteListFloat32(img.Image image, int width, int height) {
    var convertedBytes = Float32List(1 * width * height * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        var pixel = image.getPixel(x, y);
        buffer[pixelIndex++] = img.getRed(pixel) / 255.0;  // Normalize R
        buffer[pixelIndex++] = img.getGreen(pixel) / 255.0; // Normalize G
        buffer[pixelIndex++] = img.getBlue(pixel) / 255.0; // Normalize B
      }
    }
    return convertedBytes.buffer.asUint8List();
  }
}
