import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../models/subtask.dart';
import '../riverpod/tasks_provider.dart';

class TaskEditScreen extends ConsumerStatefulWidget {
  final Task task;

  const TaskEditScreen({Key? key, required this.task}) : super(key: key);

  @override
  ConsumerState<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends ConsumerState<TaskEditScreen> {
  late TextEditingController _titleController;
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
      appBar: AppBar(
        title: const Text('タスク編集'),
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: _save),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'タスク名'),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(_dueDate != null
                  ? '締切日: ${_dueDate!.toLocal().toIso8601String().split('T').first}'
                  : '締切日を選択'),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            ListTile(
              title: Text(_dueTime != null
                  ? '締切時間: ${_dueTime!.format(context)}'
                  : '時間を選択'),
              trailing: const Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            const SizedBox(height: 16),
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
            }).toList(),
            TextButton(
              onPressed: _addSubTask,
              child: const Text('+ サブタスクを追加'),
            ),
          ],
        ),
      ),
    );
  }
}
