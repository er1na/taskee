// lib/models/task.dart
import 'subtask.dart';
import 'package:flutter/material.dart';

class Task {
  String id;
  String title;
  DateTime? dueDate;
  TimeOfDay? dueTime;
  List<SubTask> subTasks;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    this.dueDate,
    this.dueTime,
    this.subTasks = const [],
    this.isDone = false,
  });

  Task copyWith({
    String? id,
    String? title,
    DateTime? dueDate,
    TimeOfDay? dueTime,
    List<SubTask>? subTasks,
    bool? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
      subTasks: subTasks ?? this.subTasks,
      isDone: isDone ?? this.isDone,
    );
  }
}
