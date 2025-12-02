# Air Notepad ✨✍️

![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)
![OpenCV](https://img.shields.io/badge/OpenCV-4.5+-green.svg)
![MediaPipe](https://img.shields.io/badge/MediaPipe-0.10+-orange.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

**Air Notepad** is an experimental project that uses **computer vision** and **machine learning** to let users draw or write on a virtual notepad using **hand gestures** captured through a camera.

This project is less about app development and more about exploring **gesture recognition**, **real-time ML inference**, and **human-computer interaction** using AI.

---

## 🎥 Demo

[![Air Notepad Demo](https://img.youtube.com/vi/t9qGOTsM9mY/maxresdefault.jpg)](https://youtu.be/t9qGOTsM9mY)

---

## 🧠 Core Idea

- Track hand landmarks using **MediaPipe Hand Landmarker model** (via Hugging Face)
- Process the detected keypoints with **OpenCV** and **NumPy**
- Convert movements into strokes on a virtual whiteboard
- Explore handwriting-to-text possibilities as a next step

👉 The main focus: understanding how raw landmark data can be transformed into structured signals for drawing and interaction.

---

## ✨ Features

 🖊️ **Multiple Drawing Tools**: Pen, Brush, and Eraser with adjustable thickness    
 
 🎨 **Color Palette**: 8 vibrant colors (Red, Blue, Green, Yellow, Purple, White, Orange, Pink)     
 👐 **Dual-Hand Control**:          
      _> Left hand for menu navigation and tool selection          
      _> Right hand for drawing            
 🎯 **Gesture-Based Interface**: Intuitive pinch and point gestures      
 🖥️ **Large Canvas**: HD resolution (1280x720) for comfortable drawing     
 🧹 **Quick Clear**: One-tap canvas clearing      
 💾 **Real-time Hand Tracking**: Smooth and responsive gesture recognition       
 📊 **Visual Feedback**: Color-coded cursors and status indicators       

---

## 🛠️ Tech Stack

- **Model & Tracking:** MediaPipe Hand Landmarker
- **Processing & Visualization:** Python, OpenCV, NumPy
- **Prototyping:** Jupyter Notebook (for experimentation and visualization)
- **(Optional UI):** Flutter/Dart – used for demo, not the core focus

---

## 🎮 How It Works

Air Notepad uses MediaPipe's Hand Landmarker model to track your hand movements in real-time:

1. **Hand Detection**: MediaPipe identifies and tracks 21 hand landmarks per hand
2. **Gesture Recognition**: Custom algorithms detect specific gestures:
   - **Pinch Gesture**: Thumb and index finger touching (for selection)
   - **Extended Index Finger**: Drawing mode activation
3. **Coordinate Mapping**: Hand landmarks are mapped to screen coordinates
4. **Smoothing Algorithm**: Weighted averaging reduces jitter for stable drawing
5. **Canvas Rendering**: OpenCV draws lines and shapes on a virtual canvas

### Hand Control System

- **Left Hand (Menu Control)**: 
  - Make a pinch gesture (thumb + index finger) to select tools and colors
  - Yellow cursor indicates position
  - Bright yellow when pinching

- **Right Hand (Drawing)**: 
  - Extend your index finger to draw on the canvas
  - Green cursor when ready to draw
  - Gray cursor when hand detected but not in drawing mode

---

## 📋 Requirements

- Python 3.8 or higher
- Webcam (built-in or external)
- Operating System: Windows, macOS, or Linux
- Good lighting conditions for optimal hand tracking

---

## 🔧 Installation

### 1. Clone the Repository
```bash
git clone https://github.com/sharmavaibhav31/air-notepad.git
cd air-notepad
```

### 2. Install Dependencies
```bash
pip install opencv-python mediapipe numpy
```

Or if a `requirements.txt` file is available:
```bash
pip install -r requirements.txt
```

### 3. Run the Application

**For Jupyter Notebook:**
```bash
jupyter notebook
# Open and run the notebook cells
```

**For Python Script:**
```bash
python air_notepad.py
```

---

## 🎨 Controls & Usage

### Getting Started
1. Position yourself comfortably in front of your webcam
2. Ensure good lighting for better hand detection
3. Keep both hands visible in the camera frame
4. The menu will appear on the left side of the screen

### Left Hand Controls (Menu Navigation)
| Gesture | Action |
|---------|--------|
| Pinch (Thumb + Index) | Select tools, colors, or clear canvas |
| Yellow Cursor | Shows hand position |
| Bright Yellow | Active selection mode |

### Right Hand Controls (Drawing)
| Gesture | Action |
|---------|--------|
| Extended Index Finger | Draw on canvas |
| Green Cursor | Ready to draw |
| Gray Cursor | Hand detected, not drawing |

### Available Tools
| Tool | Description | Thickness | Use Case |
|------|-------------|-----------|----------|
| 🖊️ Pen | Fine lines | 3px | Precise writing and details |
| 🖌️ Brush | Thicker strokes | 8px | Artistic drawing |
| 🧹 Eraser | Large eraser | 20px | Quick corrections |

### Color Palette
Red • Blue • Green • Yellow • Purple • White • Orange • Pink

### Keyboard Controls
- **`q`**: Quit the application

---

## ⚡ Challenges & Learnings

- Figuring out how to preprocess hand landmark data effectively
- Handling noise and instability in real-time tracking
- Iterating through multiple approaches for smoother stroke rendering
- Understanding the gap between ML model outputs and usable application logic

💡 Every iteration improved stability and accuracy, giving me hands-on insight into **bridging ML models with real-world applications**.

---

## 🔬 Technical Details

### Hand Tracking Pipeline
```
Camera Feed → MediaPipe Hand Detection → Landmark Extraction → 
Gesture Recognition → Coordinate Smoothing → Canvas Drawing
```

### Key Algorithms
- **Smoothing**: Weighted moving average with configurable factor (default: 0.3)
- **Pinch Detection**: Euclidean distance threshold between thumb and index finger
- **Drawing Mode**: Finger extension detection using relative Y-coordinates

### Performance Optimizations
- Dual-hand tracking with max 2 hands
- Confidence thresholds: Detection (0.8), Tracking (0.8)
- Frame-by-frame processing with minimal latency
- Efficient NumPy array operations for canvas manipulation

---

## 📁 Project Structure

```
air-notepad/
├── air_notepad.py              # Main application script
├── air_notepad.ipynb           # Jupyter notebook for experimentation
├── requirements.txt            # Python dependencies
├── README.md                   # Project documentation
└── LICENSE                     # MIT License
```

---

## 🐛 Troubleshooting

### Camera Not Detected
- Ensure your webcam is properly connected
- Try changing the camera index: `cap = cv2.VideoCapture(1)` (or 2, 3, etc.)
- Check if other applications are using the camera

### Hand Not Detected
- **Improve Lighting**: Use bright, even lighting
- **Move Closer**: Stay within 1-3 feet of the camera
- **Show Full Hand**: Ensure entire hand is visible
- **Adjust Confidence**: Lower `min_detection_confidence` to 0.5-0.7

### Laggy Performance
- Close other camera-using applications
- Reduce canvas resolution in code
- Update graphics drivers
- Lower MediaPipe confidence thresholds
- Use a more powerful computer

### Drawing Not Smooth
- Increase `smooth_factor` value (0.3 → 0.5)
- Improve lighting conditions
- Stay still relative to camera
- Ensure stable webcam mounting

### Wrong Hand Detection
- MediaPipe may confuse left/right hands in certain positions
- Try repositioning hands or adjusting camera angle
- Ensure hands don't overlap in camera view

---

## 🔮 Future Scope

- Train a lightweight handwriting recognition model on top of stroke data
- Extend to a **desktop application** with enhanced accuracy
- Add more intuitive gestures (e.g., undo, erase, change color)
- Research into **multi-modal AI** combining gesture + voice commands
- **Save & Export**: Save drawings as PNG/JPEG images
- **Undo/Redo**: Multi-level action history
- **Shape Recognition**: Convert freehand shapes to perfect geometric forms
- **Text Mode**: Handwriting-to-text conversion using OCR
- **Multi-user Collaboration**: Network-based shared canvas
- **Custom Gestures**: User-defined gesture mappings
- **3D Drawing**: Depth-based drawing with stereo cameras

---

## 🤝 Contributing

Contributions are welcome! This project is experimental and open to improvements.

### How to Contribute
1. Fork the repository
2. Create a feature branch
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. Commit your changes
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. Push to the branch
   ```bash
   git push origin feature/AmazingFeature
   ```
5. Open a Pull Request

### Areas for Contribution
- Performance optimization
- New gesture recognition patterns
- UI/UX improvements
- Documentation and tutorials
- Bug fixes and testing
- New features from Future Scope

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

You are free to:
- ✅ Use commercially
- ✅ Modify
- ✅ Distribute
- ✅ Use privately

---

## 👨‍💻 Author

**Vaibhav Sharma**

- GitHub: [@sharmavaibhav31](https://github.com/sharmavaibhav31)
- Project: [Air Notepad](https://github.com/sharmavaibhav31/air-notepad)
- YouTube: [Demo Video](https://youtu.be/t9qGOTsM9mY)

---

## 🙏 Acknowledgments

- **[MediaPipe](https://mediapipe.dev/)** - Google's powerful ML framework for hand tracking and pose estimation
- **[OpenCV](https://opencv.org/)** - The go-to computer vision library that made real-time processing possible
- **[NumPy](https://numpy.org/)** - Essential for efficient array operations and mathematical computations
- **[Hugging Face](https://huggingface.co/)** - For hosting and providing easy access to ML models
- The open-source community for inspiration and resources on gesture-based interfaces

---

## 📚 Resources & References

- [MediaPipe Hand Landmarks Documentation](https://developers.google.com/mediapipe/solutions/vision/hand_landmarker)
- [OpenCV Python Tutorials](https://docs.opencv.org/master/d6/d00/tutorial_py_root.html)
- Research papers on gesture recognition and HCI

---

⭐ **If you found this project interesting or helpful, please consider giving it a star!**

💬 **Questions or suggestions?** Feel free to open an issue or reach out.

---

**Made with ❤️, Python, and lots of hand-waving**
