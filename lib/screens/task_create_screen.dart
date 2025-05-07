// lib/screens/task_create_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskee/l10n/gen_l10n/app_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_app_bar.dart';
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
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
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
                    text: _dueDate != null
                          ? _dueTime?.format(context)
                          : '時間選択',
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() => _dueTime = picked);
                      }
                    },
                  ),
                  const Text('サブタスク'),
                  ..._subTasks.map((s) => ListTile(title: Text(s.title))),
                  Row(
                    children: [
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
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('作成する'),
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
