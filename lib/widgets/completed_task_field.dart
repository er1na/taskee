import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taskee/models/subtask.dart';
import '../models/task.dart';
import '../riverpod/tasks_provider.dart';
import '../screens/task_edit_screen.dart';
import 'checklist_circle.dart';

class CompletedTaskField extends ConsumerWidget {
  final Task completedTask;
  final VoidCallback onTap;

  const CompletedTaskField({
    super.key,
    required this.completedTask,
    required this.onTap
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFe8ecfd),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(completedTask.title),
          trailing: GestureDetector(
            onTap: onTap,
            child: Icon(Icons.refresh)
          ),
        ),
      ),
    );
  }
}