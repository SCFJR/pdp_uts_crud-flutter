import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/custom_toast_service.dart';
import '../services/task_service.dart';
import '../components/task_dialogs.dart';
import '../components/task_item_widget.dart';
import '../components/empty_state_widget.dart';

/// Halaman utama aplikasi To-Do List
/// Menangani semua operasi CRUD tugas, pencarian, dan manajemen status
class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Task> _tasks = [];
  final List<Task> _filteredTasks = []; // For search functionality
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TaskService _taskService = TaskService();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _taskController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Tangani perubahan teks pencarian
  /// Memperbarui daftar tugas yang difilter berdasarkan teks pencarian
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filterTasks();
    });
  }

  /// Temukan indeks tugas berdasarkan ID-nya
  /// Digunakan untuk mendapatkan posisi tugas dalam daftar
  int _findTaskIndex(String taskId) {
    return _taskService.findTaskIndex(_tasks, taskId);
  }

  /// Filter tugas berdasarkan kueri pencarian
  /// Memperbarui daftar tugas yang difilter untuk ditampilkan di UI
  void _filterTasks() {
    final filtered = _taskService.filterTasks(_tasks, _searchQuery);
    _filteredTasks.clear();
    _filteredTasks.addAll(filtered);
  }


  /// Muat tugas dari penyimpanan
  /// Mengambil semua tugas yang disimpan sebelumnya dan memperbarui UI
  Future<void> _loadTasks() async {
    final loadedTasks = await _taskService.loadTasks();
    setState(() {
      _tasks.clear();
      _tasks.addAll(loadedTasks);
    });
    _filterTasks(); // Refresh filtered tasks after loading
  }

  /// Simpan tugas ke penyimpanan
  /// Menyimpan semua tugas saat ini ke preferensi bersama
  Future<void> _saveTasks() async {
    await _taskService.saveTasks(_tasks);
  }



  /// Tampilkan dialog untuk menambahkan tugas baru
  /// Memungkinkan pengguna memasukkan judul dan deskripsi tugas
  void _showAddTaskDialog() {
    TaskDialogs.showAddTaskDialog(
      context,
      _taskController,
      _descriptionController,
      (String title, String? description) {
        final newTask = _taskService.createTask(title,
            description: description);
        _taskService.addTask(_tasks, newTask);
        _saveTasks();
        setState(() {
          _filterTasks(); // Refresh filtered tasks to reflect the change
        });
        _taskController.clear();
        _descriptionController.clear();

        // Show custom toast before closing dialog
        CustomToastService.showCustomToast(context, "Tugas berhasil ditambahkan");
      },
    );
  }

  /// Hapus tugas pada indeks yang ditentukan
  /// Menampilkan dialog konfirmasi sebelum menghapus
  void _deleteTask(int index) {
    if (index < 0 || index >= _tasks.length) return;

    TaskDialogs.showDeleteConfirmationDialog(
      context,
      () {
        _taskService.deleteTask(_tasks, index);
        _saveTasks();
        setState(() {
          _filterTasks(); // Refresh filtered tasks to reflect the change
        });

        // Show custom toast before closing dialog
        CustomToastService.showCustomToast(context, "Tugas berhasil dihapus");
      },
    );
  }

  /// Alihkan status penyelesaian tugas
  /// Mengubah status tugas antara selesai dan belum selesai
  void _toggleTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _taskService.toggleTaskStatus(_tasks, index);
      _saveTasks();
      setState(() {
        _filterTasks(); // Refresh filtered tasks to reflect the change
      });

      String message = _tasks[index].isDone ? "Tugas ditandai selesai" : "Tugas ditandai belum selesai";

      // Show custom toast immediately
      CustomToastService.showCustomToast(context, message);
    }
  }

  /// Edit tugas pada indeks yang ditentukan
  /// Menampilkan dialog dengan data tugas saat ini untuk diedit
  void _editTask(int index) {
    if (index < 0 || index >= _tasks.length) return;

    TaskDialogs.showEditTaskDialog(
      context,
      _taskController,
      _descriptionController,
      _tasks[index].title,
      _tasks[index].description,
      (String title, String? description) {
        _taskService.updateTask(_tasks, index,
            title: title,
            description: description);
        _saveTasks();
        setState(() {
          _filterTasks(); // Refresh filtered tasks to reflect the change
        });
        _taskController.clear();
        _descriptionController.clear();

        // Show custom toast before closing dialog
        CustomToastService.showCustomToast(context, "Perubahan tugas berhasil disimpan");
      },
    );
  }

  void _showAnggotaKelompok() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Anggota Kelompok",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2c3e50),
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("1. Muhammad Fajar Andima Maulana (2510631150059)", style: TextStyle(fontSize: 14)),
              const Text("2. Muhammad Atharaltamis (2510631150097)", style: TextStyle(fontSize: 14)),
              const Text("3. Fajar Masari Hariyanto (2510631150089)", style: TextStyle(fontSize: 14)),
              const Text("4. Satria Agung Pratama (2510631150104)", style: TextStyle(fontSize: 14)),
              const Text("5. Kurnia Adi Ramadhan (2510631150093)", style: TextStyle(fontSize: 14)),
              const Text("6. Krisna Ababil Setiawan (2510631150092)", style: TextStyle(fontSize: 14)),
              const Text("7. Hadyan Revandy Atriadjie (2510631150023)", style: TextStyle(fontSize: 14)),
              const Text("8. Muhammad Dhani Saputra (2510631150034)", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF3498db),
            ),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  void _showTentangAplikasi() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Tentang Aplikasi",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2c3e50),
          ),
        ),
        content: const Text(
          "Aplikasi To-Do List ini dibuat untuk membantu pengguna dalam mengelola tugas-tugas harian. Aplikasi ini memungkinkan pengguna untuk menambah, mengedit, menghapus, dan menandai tugas sebagai selesai. Dilengkapi dengan fitur pencarian untuk memudahkan menemukan tugas tertentu.",
          style: TextStyle(
            color: Color(0xFF7f8c8d),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF3498db),
            ),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List App", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        centerTitle: true, // Center the title to ensure it's clearly visible
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.black87), // Ensure menu icon color matches
            onSelected: (String result) {
              if (result == 'tentang') {
                _showTentangAplikasi();
              } else if (result == 'anggota') {
                _showAnggotaKelompok();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'tentang',
                child: Text('Tentang Aplikasi'),
              ),
              const PopupMenuItem<String>(
                value: 'anggota',
                child: Text('Anggota Kelompok'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFf5f7fa), Color(0xFFe4edf9)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search controls only
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Search field and clear button in same row
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFf8f9fa),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFe0e0e0), width: 1),
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: "Cari tugas...",
                                prefixIcon: Icon(Icons.search, color: Color(0xFF7f8c8d)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (_searchQuery.isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFe74c3c),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = "";
                                  _filterTasks();
                                });

                                // Show custom toast immediately
                                CustomToastService.showCustomToast(context, "Pencarian telah dibersihkan");
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                "Bersihkan",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tasks list
              Expanded(
                child: _filteredTasks.isEmpty
                    ? const EmptyStateWidget()
                    : ListView.builder(
                        key: ValueKey(_filteredTasks.length), // Add key to ensure rebuild when count changes
                        itemCount: _filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = _filteredTasks[index];

                          return TaskItemWidget(
                            task: task,
                            taskIndex: _findTaskIndex(task.id),
                            onToggle: _toggleTask,
                            onEdit: _editTask,
                            onDelete: _deleteTask,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: const Color(0xFF3498db), // Match the blue color used in other buttons
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// Search delegate for task searching
class TaskSearchDelegate extends SearchDelegate {
  final List<Task> tasks;

  TaskSearchDelegate(this.tasks);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredTasks = query.isEmpty
        ? tasks
        : tasks.where((task) =>
            task.title.toLowerCase().contains(query.toLowerCase()) ||
            (task.description != null &&
             task.description!.toLowerCase().contains(query.toLowerCase()))).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          final task = filteredTasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: Text(task.title),
              subtitle: task.description != null ? Text(task.description!) : null,
              trailing: null,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredTasks = query.isEmpty
        ? tasks
        : tasks.where((task) =>
            task.title.toLowerCase().contains(query.toLowerCase()) ||
            (task.description != null &&
             task.description!.toLowerCase().contains(query.toLowerCase()))).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          final task = filteredTasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: Text(task.title),
              subtitle: task.description != null ? Text(task.description!) : null,
              trailing: null,
              onTap: () {
                close(context, null);
              },
            ),
          );
        },
      ),
    );
  }
}
