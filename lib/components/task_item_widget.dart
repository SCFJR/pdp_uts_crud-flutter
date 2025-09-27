import 'package:flutter/material.dart';
import '../models/task.dart';

/// Widget yang menampilkan item tugas tunggal dengan elemen interaktif
/// Menampilkan judul tugas, deskripsi, tanggal pembuatan, dan tombol aksi
/// Menangani operasi toggle, edit, dan hapus melalui callback
class TaskItemWidget extends StatelessWidget {
  final Task task;
  final int taskIndex;
  final Function(int) onToggle;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const TaskItemWidget({
    Key? key,
    required this.task,
    required this.taskIndex,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(task.id), // Add key to ensure rebuild when task changes
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: task.isDone ? const Color(0xFFf8f9fa) : Colors.white, // Light gray when done, white when not
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main task row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Checkbox
                Checkbox(
                  value: task.isDone,
                  onChanged: (_) => onToggle(taskIndex),
                  side: BorderSide(
                    color: task.isDone
                      ? const Color(0xFF27ae60) // Green when checked
                      : const Color(0xFFbdc3c7), // Gray when unchecked
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // More rounded
                  ),
                  activeColor: const Color(0xFF27ae60), // Green fill when checked
                  checkColor: Colors.white, // White checkmark
                ),
                // Task title and details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title.isNotEmpty
                            ? task.title
                            : "Tanpa judul",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task.isDone ? const Color(0xFF95a5a6) : const Color(0xFF2c3e50),
                        ),
                      ),
                      if (task.description != null && task.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            task.description!,
                            style: TextStyle(
                              fontSize: 13,
                              color: task.isDone ? const Color(0xFFbdc3c7) : const Color(0xFF7f8c8d),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Dibuat: ${task.createdAt.toString().substring(0, 19)}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF95a5a6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Action buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: task.isDone ? const Color(0xFFe0e0e0) : const Color(0xFFf8f9fa), // Gray when done, light gray when not
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: task.isDone ? const Color(0xFF95a5a6) : const Color(0xFF3498db), // Gray when done, blue when not
                          size: 20,
                        ),
                        onPressed: () => onEdit(taskIndex),
                        padding: const EdgeInsets.all(6),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: task.isDone ? const Color(0xFFe0e0e0) : const Color(0xFFf8f9fa), // Gray when done, light gray when not
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: task.isDone ? const Color(0xFF95a5a6) : const Color(0xFFe74c3c), // Gray when done, red when not
                          size: 20,
                        ),
                        onPressed: () => onDelete(taskIndex),
                        padding: const EdgeInsets.all(6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}