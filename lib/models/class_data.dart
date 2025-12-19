class ClassData {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final DateTime createdAt;

  ClassData({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
  });

  factory ClassData.fromFirestore(Map<String, dynamic> data, String docId) {
    return ClassData(
      id: docId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  ClassData copyWith({
    String? id,
    String? name,
    String? description,
    String? photoUrl,
    DateTime? createdAt,
  }) {
    return ClassData(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
