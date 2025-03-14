import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

class HandTracker {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/hand_landmarker.task');
      print("✅ Hand Landmarker model loaded!");
    } catch (e) {
      print("❌ Failed to load model: $e");
    }
  }

  Future<List<dynamic>> runModel(Uint8List imageData) async {
    var output = List.filled(1 * 21 * 3, 0.0).reshape([1, 21, 3]); // Adjust shape as needed

    _interpreter.run(imageData, output);
    print("🤖 Hand Landmarks: $output");

    return output;
  }
}
