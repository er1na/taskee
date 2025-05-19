import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskee/l10n/gen_l10n/app_text.dart';
import 'task_create_screen.dart';
import '../riverpod/tasks_provider.dart';
import '../widgets/task_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/progress_task_field.dart';
import '../widgets/completed_task_field.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final taskNotifier = ref.read(tasksProvider.notifier);
    final ongoingTasks = taskNotifier.state.where((t) => !t.isDone).toList();
    final completedTasks = tasks.where((t) => t.isDone).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: CustomAppBar(
            title: AppText.of(context)!.myTasks,
            isTop: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TaskCreateScreen()),
                    );
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    size: 40,
                    color: Color(0xFF5B67CA),
                  ),
                ),
              )
            ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            // タスクスコアとグラフ（仮）
            Container(
              height: 160,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF5B67CA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppText.of(context)!.taskScore,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(
                                value: 0.75,
                                color: Colors.white,
                                backgroundColor: Colors.white24,
                              ),
                            ),
                            const Text(
                              '75%',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      '先週より15%ダウン',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            // 進行中のタスク
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                      AppText.of(context)!.tasksInProgress,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                      )
                  ),
                ),
                const SizedBox(height: 8),
                ...ongoingTasks.expand(
                        (task) => [
                          ProgressTaskField(task: task),
                          SizedBox(height: 12)
                        ]
                ),
                const SizedBox(height: 24),
                Text(
                    AppText.of(context)!.completedTasks,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                )
            ),
            const SizedBox(height: 24),
              ],
            ),
            // 週間達成状況
            Container(
              height: 140,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFe8ecfd),
                  width: 3
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(AppText.of(context)!.weeklyProgress, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(AppText.of(context)!.monday),
                      Text(AppText.of(context)!.tuesday),
                      Text(AppText.of(context)!.wednesday),
                      Text(AppText.of(context)!.thursday),
                      Text(AppText.of(context)!.friday),
                      Text(AppText.of(context)!.saturday)
                    ].map((day) {
                      return Column(
                        children: [
                          Container(
                            height: 29,
                            width: 8,
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),

                          day
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
