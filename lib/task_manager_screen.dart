import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _tasks = [];
  String _searchQuery = '';
  String _filterStatus = 'All';

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

  void _showTaskDialog({Map<String, dynamic>? task}) {
    final titleController = TextEditingController(text: task?['title']);
    final descController = TextEditingController(text: task?['description']);
    DateTime dueDate = task != null ? DateTime.parse(task['due_date']) : DateTime.now();
    String priority = task?['priority'] ?? 'Medium';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
            DropdownButton<String>(
              value: priority,
              items: ['High', 'Medium', 'Low'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (val) => setState(() => priority = val!),
            ),
            TextButton(
              child: Text('Select Due Date: ${DateFormat('yyyy-MM-dd').format(dueDate)}'),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: dueDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => dueDate = picked);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (task == null) {
                await _dbHelper.insertTask({
                  'title': titleController.text,
                  'description': descController.text,
                  'due_date': dueDate.toIso8601String(),
                  'priority': priority,
                  'completed': 0,
                });
              } else {
                await _dbHelper.updateTask(task['id'], {
                  'title': titleController.text,
                  'description': descController.text,
                  'due_date': dueDate.toIso8601String(),
                  'priority': priority,
                  'completed': task['completed'],
                });
              }
              _refreshTaskList();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    _refreshTaskList();
  }

  Future<void> _toggleCompletion(int id, bool current) async {
    await _dbHelper.updateCompletion(id, !current);
    _refreshTaskList();
  }

  List<Map<String, dynamic>> get _filteredTasks {
    return _tasks.where((task) {
      final matchSearch = task['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          task['description'].toLowerCase().contains(_searchQuery.toLowerCase());

      if (_filterStatus == 'All') return matchSearch;
      if (_filterStatus == 'Completed') return matchSearch && task['completed'] == 1;
      return matchSearch && task['completed'] == 0;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final groupedTasks = {
      'High': _filteredTasks.where((t) => t['priority'] == 'High').toList(),
      'Medium': _filteredTasks.where((t) => t['priority'] == 'Medium').toList(),
      'Low': _filteredTasks.where((t) => t['priority'] == 'Low').toList(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showTaskDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Tasks',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButton<String>(
              value: _filterStatus,
              isExpanded: true,
              items: ['All', 'Completed', 'Pending'].map((status) {
                return DropdownMenuItem(value: status, child: Text('Show $status Tasks'));
              }).toList(),
              onChanged: (value) {
                setState(() => _filterStatus = value!);
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: groupedTasks.entries.map((entry) {
                return ExpansionTile(
                  title: Text('${entry.key} Priority'),
                  children: entry.value.map((task) {
                    final completed = task['completed'] == 1;
                    return ListTile(
                      tileColor: completed ? Colors.grey[200] : null,
                      title: Text(
                        task['title'],
                        style: TextStyle(
                          decoration: completed ? TextDecoration.lineThrough : null,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${task['description'] ?? ''}\nDue: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(task['due_date']))}',
                      ),
                      isThreeLine: true,
                      leading: Checkbox(
                        value: completed,
                        onChanged: (_) => _toggleCompletion(task['id'], completed),
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showTaskDialog(task: task),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTask(task['id']),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
