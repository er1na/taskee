// lib/providers/tasks_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';
import '../models/subtask.dart';

final tasksProvider = NotifierProvider<TasksNotifier, List<Task>>(TasksNotifier.new);

class TasksNotifier extends Notifier<List<Task>> {
  final uuid = Uuid();

  late Box<Task> _box;

  @override
  List<Task> build() {
    _box = Hive.box('tasks');
    return _box.values.toList();
  }

  void addTask(
      String title, {
        DateTime? dueDate,
        TimeOfDay? dueTime,
        List<SubTask> subTasks = const [],
      }) {
    final task = Task(
      id: uuid.v4(),
      title: title,
      dueDate: dueDate,
      dueTime: dueTime,
      subTasks: subTasks,
    );
    state = [...state, task];
    _box.put(task.id, task);
  }

  void toggleTaskDone(String taskId) {
    state = state.map((task) {
      if (task.id == taskId) {
        final updated = task.copyWith(isDone: !task.isDone);
        _box.put(task.id, updated);
        return updated;
      }
      return task;
    }).toList();
  }

  void addSubTask(String taskId, String subTaskTitle) {
    state = state.map((task) {
      if (task.id == taskId) {
        final newSubTask = SubTask(id: uuid.v4(), title: subTaskTitle);
        final updated = task.copyWith(subTasks: [...task.subTasks, newSubTask]);
        _box.put(task.id, updated);
        return updated;
      }
      return task;
    }).toList();
  }

  void updateTask(Task updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task,
    ];
    _box.put(updatedTask.id, updatedTask);
  }

  void toggleSubTaskDone(String taskId, String subTaskId) {
    state = state.map((task) {
      if (task.id == taskId) {
        final updatedSubTasks = task.subTasks.map((sub) {
          if (sub.id == subTaskId) {
            return sub.copyWith(isDone: !sub.isDone);
          }
          return sub;
        }).toList();

        final allDone = updatedSubTasks.every((sub) => sub.isDone);
        final updated = task.copyWith(
          subTasks: updatedSubTasks,
          isDone: allDone,
        );

        _box.put(task.id, updated);

        return updated;
      }
      return task;
    }).toList();
  }

  void removeSubTask(String taskId, String subTaskId) {
    state = state.map((task) {
      if (task.id == taskId) {
        final updatedSubTasks = task.subTasks
            .where((sub) => sub.id != subTaskId)
            .toList();

        final updated = task.copyWith(subTasks: updatedSubTasks);
        _box.put(task.id, updated);
        return updated;
      }
      return task;
    }).toList();
  }

  void deleteTask(String taskId) {
    state = state.where((task) => task.id != taskId).toList();
    _box.delete(taskId);
  }
}
