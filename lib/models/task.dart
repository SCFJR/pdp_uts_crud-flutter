class Task {
  String id;
  String title;
  bool isDone;
  DateTime createdAt;
  String? description;

  Task({
    required this.id,
    required this.title,
    this.isDone = false,
    DateTime? createdAt,
    this.description,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'description': description ?? "",
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? "",
      title: map['title'] ?? "Tidak ada judul",
      isDone: map['isDone'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? DateTime.now().millisecondsSinceEpoch),
      description: map['description'] ?? "",
    );
  }
}
