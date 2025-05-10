import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'subtask.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime? dueDate;

  @HiveField(3)
  String? dueTimeStr;

  @HiveField(4)
  List<SubTask> subTasks;

  @HiveField(5)
  bool isDone;

  Task({
    required this.id,
    required this.title,
    this.dueDate,
    TimeOfDay? dueTime,
    this.subTasks = const [],
    this.isDone = false,
  }) : dueTimeStr = dueTime != null ? _timeToString(dueTime) : null;

  // getter: TimeOfDayに変換
  TimeOfDay? get dueTime =>
      dueTimeStr != null ? _stringToTime(dueTimeStr!) : null;

  // TimeOfDay 変換ユーティリティ
  static String _timeToString(TimeOfDay time) =>
      '${time.hour}:${time.minute}';

  static TimeOfDay _stringToTime(String str) {
    final parts = str.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  // copyWith
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
