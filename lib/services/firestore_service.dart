import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/class_data.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static const String classesCollection = 'classes';
  static const String classificationsCollection = 'classifications';
  static const String metricsCollection = 'metrics';

  Future<List<ClassData>> getClasses() async {
    try {
      final snapshot = await _db
          .collection(classesCollection)
          .orderBy('createdAt', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => ClassData.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch classes: $e');
    }
  }

  Stream<List<ClassData>> watchClasses() {
    return _db
        .collection(classesCollection)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ClassData.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  Future<ClassData?> getClassById(String classId) async {
    try {
      final doc = await _db.collection(classesCollection).doc(classId).get();
      if (doc.exists) {
        return ClassData.fromFirestore(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch class: $e');
    }
  }

  Future<void> addClass(ClassData classData) async {
    try {
      await _db
          .collection(classesCollection)
          .doc(classData.id)
          .set(classData.toFirestore());
    } catch (e) {
      throw Exception('Failed to add class: $e');
    }
  }

  Future<void> updateClass(ClassData classData) async {
    try {
      await _db
          .collection(classesCollection)
          .doc(classData.id)
          .update(classData.toFirestore());
    } catch (e) {
      throw Exception('Failed to update class: $e');
    }
  }

  Future<void> deleteClass(String classId) async {
    try {
      await _db.collection(classesCollection).doc(classId).delete();
    } catch (e) {
      throw Exception('Failed to delete class: $e');
    }
  }

  Future<void> logClassification({
    required String classId,
    required String className,
    required double confidence,
    String? userId,
  }) async {
    try {
      await _db.collection(classificationsCollection).add({
        'classId': classId,
        'className': className,
        'confidence': confidence,
        'userId': userId ?? 'anonymous',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to log classification: $e');
    }
  }
}
