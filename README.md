# Aplikasi To-Do List Flutter

Aplikasi daftar tugas sederhana yang dibangun dengan Flutter untuk manajemen tugas sehari-hari.

## Ikhtisar

Aplikasi To-Do List ini memungkinkan pengguna untuk:

- **Menambah tugas** - Dengan judul dan deskripsi opsional
- **Mengedit tugas** - Memperbarui judul atau deskripsi tugas yang sudah ada
- **Menghapus tugas** - Dengan konfirmasi untuk mencegah penghapusan yang tidak disengaja
- **Menandai tugas selesai** - Dengan kotak centang untuk melacak kemajuan
- **Mencari tugas** - Fitur pencarian untuk menemukan tugas tertentu dengan cepat

## Fitur Utama

- **Penyimpanan lokal** - Tugas disimpan secara lokal menggunakan SharedPreferences
- **Tampilan modern** - Antarmuka yang bersih dengan desain gradien dan bayangan
- **Notifikasi toast kustom** - Umpan balik pengguna untuk operasi CRUD
- **Validasi input** - Memastikan data yang dimasukkan valid
- **Pengelolaan status** - Dilengkapi dengan log untuk debugging

## Struktur Proyek

- `lib/models/task.dart` - Model data tugas
- `lib/services/task_service.dart` - Logika bisnis dan operasi CRUD
- `lib/services/custom_toast_service.dart` - Layanan notifikasi
- `lib/components/` - Komponen UI yang dapat digunakan kembali
- `lib/pages/homepage.dart` - Tampilan utama aplikasi

## Cara Menggunakan

1. Tambahkan tugas baru dengan menekan tombol tambah (+)
2. Edit atau hapus tugas dengan menekan tombol di sebelah kanan tugas
3. Tandai tugas sebagai selesai dengan mencentang kotak
4. Gunakan kotak pencarian untuk menemukan tugas tertentu
