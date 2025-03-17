import 'package:flutter/material.dart';
import 'database_helper.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _taskController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _refreshTaskList();
  }

  Future<void> _refreshTaskList() async {
    final data = await _dbHelper.getTasks();
    setState(() {
      _tasks = data;
    });
  }

  Future<void> _addTask() async {
    final taskTitle = _taskController.text.trim();
    if (taskTitle.isNotEmpty) {
      await _dbHelper.insertTask(taskTitle);
      _taskController.clear();
      _refreshTaskList();
    }
  }

  Future<void> _deleteTask(int id) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete ?? false) {
      await _dbHelper.deleteTask(id);
      _refreshTaskList();
    }
  }

  Future<void> _toggleTaskCompletion(int id, bool currentStatus) async {
    await _dbHelper.updateTaskCompletion(id, !currentStatus);
    _refreshTaskList();
  }

  Future<void> _clearCompletedTasks() async {
    await _dbHelper.deleteCompletedTasks();
    _refreshTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _clearCompletedTasks,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Task',
                      hintText: 'Enter task title',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add'),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                final completed = task['completed'] == 1;
                return ListTile(
                  title: Text(
                    task['title'],
                    style: TextStyle(
                      decoration: completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  leading: Checkbox(
                    value: completed,
                    onChanged: (_) => _toggleTaskCompletion(task['id'], completed),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTask(task['id']),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _clearCompletedTasks,
              child: const Text('Clear Completed'),
            ),
          ),
        ],
      ),
    );
  }
}
