# 💰 Expense Tracker Manager
[![Flutter](https://img.shields.io/badge/Flutter-3.22-blue?logo=flutter)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Build](https://img.shields.io/badge/Build-Passing-brightgreen)](#)

Aplikasi **Expense Tracker Manager** adalah aplikasi mobile berbasis **Flutter** yang digunakan untuk mencatat dan menganalisis pengeluaran pengguna berdasarkan kategori.  
Aplikasi ini juga memiliki fitur integrasi dengan **REST API (Posts API)** sebagai latihan komunikasi data antar server.

---

## 🚀 Fitur Utama

| Fitur | Deskripsi |
|-------|------------|
| 🧾 **Manajemen Pengeluaran** | Tambah, ubah, hapus, dan lihat daftar transaksi pengeluaran pengguna. |
| 📊 **Statistik Pengeluaran** | Menampilkan grafik pengeluaran per kategori dan periode waktu. |
| 🏷️ **Manajemen Kategori** | Kelola kategori pengeluaran agar data lebih terstruktur. |
| 👤 **Profil Pengguna** | Menampilkan data pengguna yang sedang login. |
| ⚙️ **Pengaturan Aplikasi** | Mengatur preferensi aplikasi seperti bahasa dan notifikasi. |
| ☁️ **Posts (API)** | Fitur tambahan untuk latihan REST API (GET, POST, DELETE) dengan JSONPlaceholder. |
| 🔐 **Autentikasi Login** | Sistem login/logout sederhana menggunakan `SharedPreferences`. |

---

## 🧩 Teknologi yang Digunakan

- **Flutter 3.35.4**
- **Dart 3.9.2**
- **DevTools 2.48.0**
- **HTTP package** — komunikasi REST API  
- **Shared Preferences** — penyimpanan lokal sesi pengguna  
- **Material Design 3** — komponen UI  
- **JSONPlaceholder API** — API dummy untuk testing CRUD  

---

## ⚙️ Cara Menjalankan Aplikasi

1️⃣ **Clone Repository**
```bash
git https://github.com/room1357/individual-project-3g-rankadian.git
cd individual-project-3g-rankadian
```
2️⃣ **Install Dependencies**
```bash
flutter pub get
```
3️⃣ **Jalankan di Emulator atau Device**
```bash
flutter run
```

## 📂 Struktur Folder Utama
