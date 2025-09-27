import 'package:flutter/material.dart';

/// Layanan toast kustom untuk menampilkan notifikasi pengguna
/// Menyediakan notifikasi yang diposisikan di tengah dengan warna tema aplikasi
class CustomToastService {
  /// Tampilkan notifikasi toast kustom di bagian bawah layar
  /// Menggunakan warna primer aplikasi dan tata letak yang diposisikan di tengah
  static void showCustomToast(BuildContext context, String message) {
    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.8, // Position near the bottom
        left: 0,
        right: 0,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: const Color(0xFF2c3e50), // Match app's primary dark color
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                decoration: TextDecoration.none, // Explicitly set no decoration to remove underline
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    // Remove the overlay after the duration
    Future.delayed(const Duration(seconds: 2), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}