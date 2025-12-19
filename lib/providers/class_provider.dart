import 'package:flutter/foundation.dart';
import '../models/class_data.dart';
import '../services/firestore_service.dart';
import '../data/sample_data.dart';

class ClassProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<ClassData> _classes = [];
  bool _isLoading = false;
  String? _error;

  List<ClassData> get classes => _classes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ClassProvider() {
    _loadInitialData();
  }

  void _loadInitialData() {
    _classes = List.from(sampleSportsCars);
    notifyListeners();
  }

  Future<void> fetchClasses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _classes = await _firestoreService.getClasses();
      _error = null;
    } catch (e) {
      _error = 'Using sample data (Firebase not configured)';
      _classes = List.from(sampleSportsCars);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void watchClasses() {
    _firestoreService.watchClasses().listen(
      (classList) {
        _classes = classList;
        _error = null;
        notifyListeners();
      },
      onError: (e) {
        _error = 'Using sample data (Firestore error)';
        _classes = List.from(sampleSportsCars);
        notifyListeners();
      },
    );
  }

  Future<void> addClass(ClassData classData) async {
    try {
      await _firestoreService.addClass(classData);
      await fetchClasses();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateClass(ClassData classData) async {
    try {
      await _firestoreService.updateClass(classData);
      await fetchClasses();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteClass(String classId) async {
    try {
      await _firestoreService.deleteClass(classId);
      await fetchClasses();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logClassification({
    required String classId,
    required String className,
    required double confidence,
    String? userId,
  }) async {
    try {
      await _firestoreService.logClassification(
        classId: classId,
        className: className,
        confidence: confidence,
        userId: userId,
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
