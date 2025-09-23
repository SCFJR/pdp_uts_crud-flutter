import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? taskList = prefs.getStringList('tasks');
    if (taskList != null) {
      setState(() {
        _tasks.clear();
        _tasks.addAll(
          taskList.map((item) => Task.fromMap(jsonDecode(item))).toList(),
        );
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> taskList = _tasks
        .map((e) => jsonEncode({"title": e.title, "isDone": e.isDone}))
        .toList();
    await prefs.setStringList('tasks', taskList);
  }

  void _addTask(String title) {
    if (title.isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: title.isNotEmpty ? title : "Tidak ada judul"));
      });
      _saveTasks();
      _taskController.clear();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
    _saveTasks();
  }

  void _editTask(int index) {
    _taskController.text =
        _tasks[index].title.isNotEmpty ? _tasks[index].title : "";
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Tugas"),
        content: TextField(
          controller: _taskController,
          decoration: const InputDecoration(hintText: "Edit Nama Tugas"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _tasks[index].title = _taskController.text.isNotEmpty
                    ? _taskController.text
                    : "Tidak ada judul";
              });
              _saveTasks();
              _taskController.clear();
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Crud TodoListApp Kelompok 4"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: "Tambah Tugas",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addTask(_taskController.text),
                  child: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada tugas, tambahkan di atas!",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Checkbox(
                              value: task.isDone,
                              onChanged: (_) => _toggleTask(index),
                            ),
                            title: Text(
                              task.title.isNotEmpty
                                  ? task.title
                                  : "Tidak ada judul",
                              style: TextStyle(
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon:
                                      const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editTask(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _deleteTask(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
