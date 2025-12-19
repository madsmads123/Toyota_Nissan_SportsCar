import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../services/ml_service.dart';
import 'classification_result_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late MLService _mlService;
  bool _isInitialized = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeML();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        _showError('No cameras available');
        return;
      }

      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
      );

      await _cameraController.initialize();
      if (mounted) {
        setState(() => _isInitialized = true);
      }
    } catch (e) {
      _showError('Failed to initialize camera: $e');
    }
  }

  Future<void> _initializeML() async {
    try {
      _mlService = MLService();
      await _mlService.initialize();
    } catch (e) {
      if (mounted) {
        _showError('Failed to load ML model: $e');
      }
    }
  }

  Future<void> _captureAndClassify() async {
    if (_isProcessing || !_mlService.isInitialized) return;

    try {
      setState(() => _isProcessing = true);

      final image = await _cameraController.takePicture();
      final imageBytes = await image.readAsBytes();

      final result = await _mlService.classifyImage(imageBytes);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassificationResultScreen(
              carModelName: result['className'] as String,
              confidence: double.parse(result['confidence']),
              classId: result['classId'] as String,
            ),
          ),
        );
      }
    } catch (e) {
      _showError('Classification failed: $e');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _mlService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Classify Sports Car'),
          elevation: 2,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classify Sports Car'),
        elevation: 2,
      ),
      body: Stack(
        children: [
          CameraPreview(_cameraController),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Point camera at sports car',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: FloatingActionButton.extended(
                      onPressed: _isProcessing ? null : _captureAndClassify,
                      label: _isProcessing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text('Capture & Classify'),
                      icon: const Icon(Icons.camera),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
