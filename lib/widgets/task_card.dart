import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../riverpod/tasks_provider.dart';
import '../screens/task_edit_screen.dart';

class TaskCard extends ConsumerWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedSubTasks = task.subTasks.where((sub) => sub.isDone).length;
    final totalSubTasks = task.subTasks.length;
    final dueDateText =
    task.dueDate != null ? '${task.dueDate!.month}/${task.dueDate!.day}' : '';
    final dueTimeText = task.dueTime != null ? task.dueTime!.format(context) : '';
    final subtitle = totalSubTasks > 0 ? '進捗: $completedSubTasks / $totalSubTasks' : null;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TaskEditScreen(task: task),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: (_) {
                  ref.read(tasksProvider.notifier).toggleTaskDone(task.id);
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: task.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (dueDateText.isNotEmpty)
                    Text(
                      dueDateText,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  if (dueTimeText.isNotEmpty)
                    Text(
                      dueTimeText,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
