import 'package:flutter/material.dart';

/// Kelas komponen yang menangani semua interaksi dialog terkait tugas
/// Menyediakan metode untuk menampilkan dialog tambah, edit, dan konfirmasi hapus
/// Setiap dialog memiliki validasi dan umpan balik pengguna yang tepat
class TaskDialogs {

  /// Tampilkan dialog untuk menambahkan tugas baru
  /// Membersihkan kontrol sebelum menampilkan, memvalidasi input, dan memanggil callback onAddTask saat valid
  /// Termasuk validasi untuk nama tugas kosong dan batas karakter
  static void showAddTaskDialog(
    BuildContext context,
    TextEditingController taskController,
    TextEditingController descriptionController,
    Function(String, String?) onAddTask,
  ) {
    taskController.clear();
    descriptionController.clear();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, dialogSetState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.white, // Set background to white to match the app's design
            title: const Text(
              "Tambah Tugas Baru",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c3e50),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    labelText: "Nama Tugas",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFf8f9fa),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Deskripsi (opsional)",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFf8f9fa),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                ),
              ],
            ),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF95a5a6), // Gray text
                  side: const BorderSide(color: Color(0xFF95a5a6)), // Gray border
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Batal", style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              ElevatedButton(
                onPressed: () {
                  if (taskController.text.trim().isEmpty) {
                    _showErrorDialog(context, "Nama tugas tidak boleh kosong!");
                    return;
                  }

                  if (taskController.text.length > 100) {
                    _showErrorDialog(context, "Nama tugas tidak boleh lebih dari 100 karakter!");
                    return;
                  }

                  if (descriptionController.text.length > 500) {
                    _showErrorDialog(context, "Deskripsi tidak boleh lebih dari 500 karakter!");
                    return;
                  }

                  onAddTask(taskController.text.trim(),
                      descriptionController.text.isEmpty ? null : descriptionController.text);

                  Navigator.pop(context); // Close the dialog after adding the task
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3498db), // Blue background to match the edit icon
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Tambah Tugas",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Tampilkan dialog untuk mengedit tugas yang ada
  /// Mengisi ulang kontrol dengan data tugas yang ada, memvalidasi input, dan memanggil callback onEditTask saat valid
  /// Termasuk validasi untuk nama tugas kosong dan batas karakter
  static void showEditTaskDialog(
    BuildContext context,
    TextEditingController taskController,
    TextEditingController descriptionController,
    String initialTitle,
    String? initialDescription,
    Function(String, String?) onEditTask,
  ) {
    taskController.text = initialTitle.isNotEmpty ? initialTitle : "";
    descriptionController.text = initialDescription ?? "";

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, dialogSetState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.white, // Set background to white to match the app's design
            title: const Text(
              "Edit Tugas",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c3e50),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    labelText: "Nama Tugas",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFf8f9fa),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Deskripsi (opsional)",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFf8f9fa),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                ),
              ],
            ),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF95a5a6), // Gray text
                  side: const BorderSide(color: Color(0xFF95a5a6)), // Gray border
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Batal", style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              ElevatedButton(
                onPressed: () {
                  if (taskController.text.trim().isEmpty) {
                    _showErrorDialog(context, "Nama tugas tidak boleh kosong!");
                    return;
                  }

                  if (taskController.text.length > 100) {
                    _showErrorDialog(context, "Nama tugas tidak boleh lebih dari 100 karakter!");
                    return;
                  }

                  if (descriptionController.text.length > 500) {
                    _showErrorDialog(context, "Deskripsi tidak boleh lebih dari 500 karakter!");
                    return;
                  }

                  onEditTask(taskController.text.trim(),
                      descriptionController.text.isEmpty ? null : descriptionController.text);

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3498db), // Blue background to match the edit icon
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Tampilkan dialog konfirmasi sebelum menghapus tugas
  /// Meminta konfirmasi dari pengguna sebelum melanjutkan penghapusan
  static void showDeleteConfirmationDialog(
    BuildContext context,
    Function() onDeleteTask,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Konfirmasi Hapus",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFe74c3c),
          ),
        ),
        content: const Text(
          "Apakah Anda yakin ingin menghapus tugas ini?",
          style: TextStyle(
            color: Color(0xFF7f8c8d),
            fontSize: 14,
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF95a5a6), // Gray text
              side: const BorderSide(color: Color(0xFF95a5a6)), // Gray border
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Tidak", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              onDeleteTask();
              Navigator.pop(context); // Close the confirmation dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFe74c3c), // Red background for delete
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Iya",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  /// Tampilkan dialog kesalahan dengan pesan yang ditentukan
  /// Digunakan untuk menampilkan kesalahan validasi atau masalah lainnya kepada pengguna
  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.white, // Set background to white to match the app's design
        title: const Text(
          "Kesalahan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFe74c3c),
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Color(0xFF7f8c8d),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}