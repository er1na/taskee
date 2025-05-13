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
      height: 13,
      width: 13,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFe8ecfd)
      ),
      child: Center(
        child: GestureDetector(
          child: Container(
            height: 7,
            width: 7,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: isDone
                ? Color(0xFF5B67CA)
                : Color(0xFF5B67CA).withOpacity(0)
            ),
          ),
        ),
      ),
    );
  }
}