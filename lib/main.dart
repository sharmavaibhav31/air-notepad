import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'hand_tracker.dart';

void main() {
  runApp(const AirNotepad());
}

class AirNotepad extends StatelessWidget {
  const AirNotepad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Air Notepad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Air Notepad')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Initialize the hand tracker model
            HandTracker tracker = HandTracker();
            await tracker.loadModel();

            // Navigate to Camera Screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraScreen(handTracker: tracker)),
            );
          },
          child: const Text('Open Camera'),
        ),
      ),
    );
  }
}
