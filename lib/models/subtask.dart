// lib/models/subtask.dart
class SubTask {
  String id;
  String title;
  bool isDone;

  SubTask({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  SubTask copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return SubTask(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
