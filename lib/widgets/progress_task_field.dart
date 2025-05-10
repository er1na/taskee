import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taskee/models/subtask.dart';
import '../models/task.dart';
import '../riverpod/tasks_provider.dart';
import '../screens/task_edit_screen.dart';
import 'checklist_circle.dart';

class ProgressTaskField extends ConsumerWidget{
  final Task task;

  const ProgressTaskField({
    super.key,
    required this.task
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final ongoingTaskTitle = task.title;
    final ongoingSubTasks = task.subTasks;
    final deadlineDate = DateFormat('MM/dd').format(task.dueDate!);
    final deadlineTime = task.dueTime!.format(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFe8ecfd),
          width: 3
        ),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ongoingTaskTitle,
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "締切：$deadlineDate $deadlineTime",
            ),
          ),
          Row(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: ongoingSubTasks.length,
                itemBuilder: (context, index){
                  return Text(ongoingSubTasks[index].title);
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: ongoingSubTasks.length,
                itemBuilder: (context, index){
                  return ChecklistCircle(
                    isDone: ongoingSubTasks[index].isDone,
                    onTap: (){
                        ref
                            .read(tasksProvider.notifier)
                            .toggleSubTaskDone(task.id, ongoingSubTasks[index].id);
                    },
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}