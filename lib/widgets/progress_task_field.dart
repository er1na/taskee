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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  ongoingTaskTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskEditScreen(task: task)
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 20,
                    )
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                "締切：$deadlineDate $deadlineTime",
              ),
            ),
            SizedBox(height: 5),
            Column(
              children: List.generate(ongoingSubTasks.length, (index) {
                final subTask = ongoingSubTasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: (){
                      ref.read(tasksProvider.notifier).toggleSubTaskDone(task.id, subTask.id);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ChecklistCircle(
                          isDone: subTask.isDone,
                          onTap: () {
                            ref
                                .read(tasksProvider.notifier);
                          },
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            subTask.title,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}