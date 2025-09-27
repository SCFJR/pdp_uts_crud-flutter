import 'package:flutter/material.dart';

/// Widget yang menampilkan keadaan kosong ketika tidak ada tugas
/// Menampilkan ikon dan pesan ramah untuk membimbing pengguna
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 80,
            color: const Color(0xFFbdc3c7),
          ),
          const SizedBox(height: 16),
          const Text(
            "Belum ada tugas",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF7f8c8d),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tambah tugas baru untuk memulai",
            style: TextStyle(
              color: Color(0xFF95a5a6),
            ),
          ),
        ],
      ),
    );
  }
}