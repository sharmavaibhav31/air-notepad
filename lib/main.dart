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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  Future<void> _openCamera() async {
    setState(() {
      _isLoading = true;
    });

    HandTracker tracker = HandTracker();
    await tracker.loadModel();

    if (!mounted) return; // Prevents navigation if widget is disposed

    setState(() {
      _isLoading = false;
    });

    // Check if the model loaded successfully
    if (tracker.interpreter != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraScreen(handTracker: tracker),
        ),
      );
    } else {
      // Show error message if model fails to load
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Failed to load hand tracking model. Please try again."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Air Notepad')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Show loading indicator while model is loading
            : ElevatedButton(
          onPressed: _openCamera,
          child: const Text('Open Camera'),
        ),
      ),
    );
  }
}
