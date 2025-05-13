import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskee/widgets/custom_app_bar.dart';
import 'package:taskee/widgets/custom_text_field.dart';
import 'package:taskee/widgets/custom_text_button.dart';
import 'package:taskee/l10n/gen_l10n/app_text.dart';
import '../models/task.dart';
import '../models/subtask.dart';
import '../riverpod/tasks_provider.dart';

class TaskEditScreen extends ConsumerStatefulWidget {
  final Task task;

  const TaskEditScreen({
    super.key, required this.task
  });

  @override
  ConsumerState<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends ConsumerState<TaskEditScreen> {
  late TextEditingController _titleController;
  final _formKey = GlobalKey<FormState>();
  DateTime? _dueDate;
  TimeOfDay? _dueTime;
  late List<SubTask> _subTasks;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _dueDate = widget.task.dueDate;
    _dueTime = widget.task.dueTime;
    _subTasks = [...widget.task.subTasks];
  }

  void _save() {
    final updatedTask = widget.task.copyWith(
      title: _titleController.text,
      dueDate: _dueDate,
      dueTime: _dueTime,
      subTasks: _subTasks,
    );

    ref.read(tasksProvider.notifier).updateTask(updatedTask);
    Navigator.of(context).pop();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _dueTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _dueTime = picked);
  }

  void _addSubTask() {
    setState(() {
      _subTasks.add(SubTask(id: UniqueKey().toString(), title: ""));
    });
  }

  void _updateSubTask(int index, String title) {
    setState(() {
      _subTasks[index] = _subTasks[index].copyWith(title: title);
    });
  }

  void _deleteSubTask(int index) {
    setState(() {
      _subTasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'aaa',
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
              onPressed: _save
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                CustomTextField(
                  controller: _titleController,
                  hint: AppText.of(context)!.taskName,
                ),
                const SizedBox(height: 15),
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
                        ? '締切時間: ${_dueTime!.format(context)}'
                        : '時間を選択',
                    onPressed: _pickTime
                ),
                const Text('サブタスク'),
                ..._subTasks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final sub = entry.value;
                  return ListTile(
                    leading: const Icon(Icons.drag_indicator),
                    title: TextField(
                      controller: TextEditingController(text: sub.title),
                      onChanged: (val) => _updateSubTask(index, val),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteSubTask(index),
                    ),
                  );
                }),
                TextButton(
                  onPressed: _addSubTask,
                  child: const Text('+ サブタスクを追加'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
