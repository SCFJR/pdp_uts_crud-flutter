import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

/// Kelas layanan untuk menangani semua operasi terkait tugas
/// Menyediakan metode untuk operasi CRUD, filter, dan manajemen tugas
class TaskService {
  static final TaskService _instance = TaskService._internal();
  factory TaskService() => _instance;
  TaskService._internal();

  final Uuid _uuid = const Uuid();

  /// Muat tugas dari penyimpanan preferensi bersama
  /// Mengembalikan daftar kosong jika tidak ada tugas yang ada
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? taskList = prefs.getStringList('tasks');
    if (taskList != null) {
      return taskList.map((item) => Task.fromMap(jsonDecode(item))).toList();
    } else {
      return [];
    }
  }

  /// Simpan tugas ke penyimpanan preferensi bersama
  /// Mengonversi tugas ke format JSON sebelum menyimpan
  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> taskList = tasks
        .map((e) => jsonEncode(e.toMap()))
        .toList();
    await prefs.setStringList('tasks', taskList);
  }

  /// Buat tugas baru dengan ID unik
  /// Menerima judul dan deskripsi opsional
  Task createTask(String title, {String? description}) {
    return Task(
      id: _uuid.v4(),
      title: title.trim(),
      description: description,
    );
  }

  /// Tambahkan tugas ke daftar
  void addTask(List<Task> tasks, Task task) {
    tasks.add(task);
  }

  /// Perbarui properti tugas pada indeks yang ditentukan
  /// Memungkinkan pembaruan judul, deskripsi, dan status penyelesaian
  void updateTask(List<Task> tasks, int index, {String? title, String? description, bool? isDone}) {
    if (index >= 0 && index < tasks.length) {
      tasks[index] = Task(
        id: tasks[index].id,
        title: title ?? tasks[index].title,
        description: description ?? tasks[index].description,
        isDone: isDone ?? tasks[index].isDone,
        createdAt: tasks[index].createdAt,
      );
    }
  }

  /// Hapus tugas pada indeks yang ditentukan
  void deleteTask(List<Task> tasks, int index) {
    if (index >= 0 && index < tasks.length) {
      tasks.removeAt(index);
    }
  }

  /// Alihkan status penyelesaian tugas
  void toggleTaskStatus(List<Task> tasks, int index) {
    if (index >= 0 && index < tasks.length) {
      tasks[index].isDone = !tasks[index].isDone;
    }
  }

  /// Filter tugas berdasarkan kueri pencarian
  /// Mencocokkan terhadap judul dan deskripsi (tidak sensitif terhadap huruf besar/kecil)
  List<Task> filterTasks(List<Task> tasks, String query) {
    if (query.isEmpty) {
      return List.from(tasks);
    } else {
      return tasks.where((task) =>
          task.title.toLowerCase().contains(query.toLowerCase()) ||
          (task.description != null && task.description!.toLowerCase().contains(query.toLowerCase()))
      ).toList();
    }
  }

  /// Temukan indeks tugas berdasarkan ID uniknya
  /// Mengembalikan -1 jika tugas tidak ditemukan
  int findTaskIndex(List<Task> tasks, String taskId) {
    return tasks.indexWhere((task) => task.id == taskId);
  }
}