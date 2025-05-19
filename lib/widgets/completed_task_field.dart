import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taskee/models/subtask.dart';
import '../models/task.dart';
import '../riverpod/tasks_provider.dart';
import '../screens/task_edit_screen.dart';
import 'checklist_circle.dart';

class CompletedTaskField extends StatelessWidget {
  final Task completedTask;

  const CompletedTaskField({
    super.key,
    required this.completedTask
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(completedTask.title),
    );
  }
}