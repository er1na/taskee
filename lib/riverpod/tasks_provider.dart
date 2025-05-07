// lib/providers/tasks_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';
import '../models/subtask.dart';

final tasksProvider =
StateNotifierProvider<TasksProvider, List<Task>>((ref) => TasksProvider());

class TasksProvider extends StateNotifier<List<Task>> {
  TasksProvider() : super([]);

  final uuid = Uuid();

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
  }

  void toggleTaskDone(String taskId) {
    state = state.map((task) {
      if (task.id == taskId) {
        return Task(
          id: task.id,
          title: task.title,
          dueDate: task.dueDate,
          dueTime: task.dueTime,
          subTasks: task.subTasks,
          isDone: !task.isDone,
        );
      }
      return task;
    }).toList();
  }

  void addSubTask(String taskId, String subTaskTitle) {
    state = state.map((task) {
      if (task.id == taskId) {
        final newSubTask = SubTask(id: uuid.v4(), title: subTaskTitle);
        return Task(
          id: task.id,
          title: task.title,
          dueDate: task.dueDate,
          dueTime: task.dueTime,
          subTasks: [...task.subTasks, newSubTask],
          isDone: task.isDone,
        );
      }
      return task;
    }).toList();
  }

  void updateTask(Task updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task,
    ];
  }

  void toggleSubTaskDone(String taskId, String subTaskId) {
    state = state.map((task) {
      if (task.id == taskId) {
        final updatedSubTasks = task.subTasks.map((sub) {
          if (sub.id == subTaskId) {
            return SubTask(id: sub.id, title: sub.title, isDone: !sub.isDone);
          }
          return sub;
        }).toList();

        return Task(
          id: task.id,
          title: task.title,
          dueDate: task.dueDate,
          dueTime: task.dueTime,
          subTasks: updatedSubTasks,
          isDone: task.isDone,
        );
      }
      return task;
    }).toList();
  }
}
