import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taskee/models/subtask.dart';
import '../models/task.dart';
import '../riverpod/tasks_provider.dart';
import '../screens/task_edit_screen.dart';
import 'checklist_circle.dart';

class ChecklistCircle extends StatelessWidget{
  final bool isDone;
  final VoidCallback onTap;

  const ChecklistCircle(
      {
        super.key,
        required this.isDone,
        required this.onTap
      }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amber
      ),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 20,
            width: 20,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: isDone
                ? Colors.blue
                : Colors.blue.withOpacity(0)
            ),
          ),
        ),
      ),
    );
  }
}