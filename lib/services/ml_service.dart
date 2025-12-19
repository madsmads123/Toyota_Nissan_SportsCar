import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class MLService {
  static const String modelPath = 'assets/model_unquant.tflite';
  static const String labelsPath = 'assets/labels.txt';

  List<String> labels = [];
  bool _isInitialized = false;
  final Random _random = Random();

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    try {
      await _loadLabels();
      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize ML model: $e');
    }
  }

  Future<void> _loadLabels() async {
    final labelData = await rootBundle.loadString(labelsPath);
    labels = labelData.split('\n').where((line) => line.isNotEmpty).map((line) {
      if (line.isEmpty) return '';
      final spaceIndex = line.indexOf(' ');
      if (spaceIndex == -1) return line;
      return line.substring(spaceIndex + 1).trim();
    }).toList();
  }

  Future<Map<String, dynamic>> classifyImage(Uint8List imageBytes) async {
    if (!_isInitialized) {
      throw Exception('ML model not initialized');
    }

    try {
      final image = img.decodeImage(imageBytes);
      if (image == null) {
        throw Exception('Failed to decode image');
      }

      await Future.delayed(const Duration(seconds: 2));

      final predictions = _generateMockPredictions();
      final maxIndex = predictions.indexOf(predictions.reduce((a, b) => a > b ? a : b));
      final confidence = predictions[maxIndex];
      final label = labels[maxIndex];

      return {
        'className': label,
        'classId': 'class_$maxIndex',
        'confidence': confidence.toStringAsFixed(4),
        'allPredictions': predictions,
      };
    } catch (e) {
      throw Exception('Classification failed: $e');
    }
  }

  List<double> _generateMockPredictions() {
    final predictions = List<double>.filled(labels.length, 0.0);
    
    final maxIndex = _random.nextInt(labels.length);
    double sum = 0;
    
    for (int i = 0; i < labels.length; i++) {
      double value;
      if (i == maxIndex) {
        value = 0.6 + _random.nextDouble() * 0.35;
      } else {
        value = _random.nextDouble() * 0.2;
      }
      predictions[i] = value;
      sum += value;
    }
    
    for (int i = 0; i < labels.length; i++) {
      predictions[i] = predictions[i] / sum;
    }
    
    return predictions;
  }

  void dispose() {
  }
}
