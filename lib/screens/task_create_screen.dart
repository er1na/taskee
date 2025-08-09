// lib/screens/task_create_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskee/l10n/gen_l10n/app_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/subtask_tile.dart';
import 'package:uuid/uuid.dart';

import '../riverpod/tasks_provider.dart';
import '../models/subtask.dart';

class TaskCreateScreen extends ConsumerStatefulWidget {
  const TaskCreateScreen({super.key});

  @override
  ConsumerState<TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends ConsumerState<TaskCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subTaskController = TextEditingController();
  final List<SubTask> _subTasks = [];

  DateTime? _dueDate;
  TimeOfDay? _dueTime;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final filteredSubTasks =
      _subTasks.where((s) => s.title.trim().isNotEmpty).toList();

      ref.read(tasksProvider.notifier).addTask(
        _titleController.text.trim(),
        dueDate: _dueDate,
        dueTime: _dueTime,
        subTasks: filteredSubTasks,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('タスクを作成しました')),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(
        title: AppText.of(context)!.newTask,
        isTop: false,
        actions: [
          IconButton(
              icon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 20, 0),
                child: const Icon(
                                Icons.check_circle,
                                size: 32,
                                color: Color(0xFF5B67CA),
                ),
              ),
              onPressed: (){_submit();}
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomTextField(
                      controller: _titleController,
                      hint: AppText.of(context)!.taskName
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 13),
                      Text("締切",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  CustomTextButton(
                    text: _dueDate!=null
                        ? _dueDate!.toLocal().toString().split(' ')[0]
                        : '日付選択',
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => _dueDate = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomTextButton(
                    text: _dueTime != null
                          ? _dueTime?.format(context)
                          : '時間選択',
                    onPressed:
                        _dueDate == null
                         ? (){}
                         : () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() => _dueTime = picked);
                              }
                            },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 13),
                      const Text(
                        'サブタスク',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  ..._subTasks.expand((s) => [
                    SubtaskTile(
                      subtaskTitle: s.title,
                      callback: () {
                        setState(() {
                          _subTasks.removeWhere((sub) => sub.id == s.id);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: _subTaskController,
                            decoration: const InputDecoration(hintText: 'サブタスク追加'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            final title = _subTaskController.text.trim();
                            if (title.isNotEmpty) {
                              setState(() {
                                _subTasks.add(SubTask(
                                  id: const Uuid().v4(),
                                  title: title,
                                ));
                                _subTaskController.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
