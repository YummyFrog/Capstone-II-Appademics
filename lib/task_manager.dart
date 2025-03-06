import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'database_helper.dart';

void main() {
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TaskPage(),
    );
  }
}

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

  // Retrieve tasks from the database and update the state
  Future<void> _refreshTaskList() async {
    final data = await _dbHelper.getTasks();
    setState(() {
      _tasks = data;
    });
  }

  // Insert a new task
  Future<void> _addTask() async {
    final taskTitle = _taskController.text.trim();
    if (taskTitle.isNotEmpty) {
      await _dbHelper.insertTask(taskTitle);
      _taskController.clear();
      _refreshTaskList();
    }
  }

  // Delete a task
  Future<void> _deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    _refreshTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Task Manager'),
      ),
      body: Column(
        children: [
          // Input field and button to add new task
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Text field
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Add button
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add'),
                )
              ],
            ),
          ),
          // Display tasks
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (BuildContext context, int index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(task['title'] ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTask(task['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
