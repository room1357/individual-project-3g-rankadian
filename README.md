# 💰 Expense Tracker Manager

[![Flutter](https://img.shields.io/badge/Flutter-3.22-blue?logo=flutter)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Build](https://img.shields.io/badge/Build-Passing-brightgreen)](#)

Aplikasi **Expense Tracker Manager** adalah aplikasi mobile berbasis **Flutter** yang digunakan untuk mencatat dan menganalisis pengeluaran pengguna berdasarkan kategori.  
Aplikasi ini juga memiliki fitur integrasi dengan **REST API (Posts API)** sebagai latihan komunikasi data antar server.

---

## 🚀 Fitur Utama

| Fitur                        | Deskripsi                                                                         |
| ---------------------------- | --------------------------------------------------------------------------------- |
| 🧾 **Manajemen Pengeluaran** | Tambah, ubah, hapus, dan lihat daftar transaksi pengeluaran pengguna.             |
| 📊 **Statistik Pengeluaran** | Menampilkan grafik pengeluaran per kategori dan periode waktu.                    |
| 🏷️ **Manajemen Kategori**    | Kelola kategori pengeluaran agar data lebih terstruktur.                          |
| 👤 **Profil Pengguna**       | Menampilkan data pengguna yang sedang login.                                      |
| ⚙️ **Pengaturan Aplikasi**   | Mengatur preferensi aplikasi seperti bahasa dan notifikasi.                       |
| ☁️ **Posts (API)**           | Fitur tambahan untuk latihan REST API (GET, POST, DELETE) dengan JSONPlaceholder. |
| 🔐 **Autentikasi Login**     | Sistem login/logout sederhana menggunakan `SharedPreferences`.                    |

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

---

## 📂 Struktur Folder Utama

```plaintext
lib
│   main.dart                       # Entry point utama aplikasi
│   rest_client.dart                # Client HTTP dasar (tidak digunakan langsung)
│
├───client
│       rest_client.dart            # Implementasi REST client untuk konsumsi API JSONPlaceholder
│
├───models
│       category.dart               # Model data kategori pengeluaran
│       expense.dart                # Model data pengeluaran
│       post.dart                   # Model data postingan (API)
│       user.dart                   # Model data pengguna
│
├───screens
│       about_screen.dart               # Halaman tentang aplikasi
│       add_expense_screen.dart         # Form tambah pengeluaran baru
│       advanced_expense_list_screen.dart  # Daftar pengeluaran lengkap (fitur utama)
│       category_screen.dart            # Manajemen kategori pengeluaran
│       edit_expense_screen.dart        # Form edit pengeluaran
│       edit_profile_screen.dart        # Form edit profil pengguna
│       expense_list_screen.dart        # Tampilan daftar pengeluaran sederhana
│       home_screen.dart                # Halaman utama (menu cepat & ringkasan)
│       login_screen.dart               # Halaman login pengguna
│       posts_screen.dart               # Halaman demonstrasi API eksternal (CRUD Post)
│       profile_screen.dart             # Halaman profil pengguna
│       register_screen.dart            # Halaman pendaftaran pengguna
│       settings_screen.dart            # Halaman pengaturan aplikasi
│       statistics_screen.dart          # Halaman statistik & grafik pengeluaran
│
├───services
│       auth_service.dart               # Layanan autentikasi (login/logout)
│       expense_manager.dart            # Logika tambahan untuk pengelolaan pengeluaran
│       expense_service.dart            # CRUD data pengeluaran (local + shared preferences)
│       looping_examples.dart           # Contoh fungsi looping (latihan/eksperimen)
│       post_service.dart               # CRUD data posts via REST API
│
├───utils
│       currency_utils.dart             # Utilitas format mata uang (Rp)
│       date_utils.dart                 # Utilitas format dan manipulasi tanggal
│
└───widgets
        expense_card.dart               # Widget tampilan kartu pengeluaran
```

---

## 🧠 Penjelasan Setiap Halaman

| File                                  | Deskripsi Singkat                                                                                                         |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **home_screen.dart**                  | Tampilan utama aplikasi. Menampilkan sapaan pengguna, ringkasan cepat, dan menu navigasi ke fitur lain.                   |
| **login_screen.dart**                 | Halaman untuk login pengguna dengan validasi input.                                                                       |
| **register_screen.dart**              | Form pendaftaran pengguna baru.                                                                                           |
| **advanced_expense_list_screen.dart** | Daftar pengeluaran lengkap dengan opsi tambah, edit, dan hapus.                                                           |
| **add_expense_screen.dart**           | Form untuk menambahkan pengeluaran baru.                                                                                  |
| **edit_expense_screen.dart**          | Form untuk memperbarui pengeluaran yang sudah ada.                                                                        |
| **statistics_screen.dart**            | Menampilkan grafik dan ringkasan statistik pengeluaran bulanan.                                                           |
| **category_screen.dart**              | Mengelola daftar kategori pengeluaran.                                                                                    |
| **profile_screen.dart**               | Menampilkan profil pengguna dan tombol edit profil.                                                                       |
| **edit_profile_screen.dart**          | Form untuk mengubah nama/email pengguna.                                                                                  |
| **settings_screen.dart**              | Pengaturan aplikasi seperti notifikasi, bahasa, versi, dan tautan ke halaman _About_.                                     |
| **about_screen.dart**                 | Informasi singkat tentang aplikasi dan pengembang.                                                                        |
| **posts_screen.dart**                 | Menampilkan daftar posting dari API eksternal (_JSONPlaceholder_). Dapat menambah, menghapus, dan memuat ulang postingan. |
| **expense_list_screen.dart**          | Tampilan daftar pengeluaran sederhana, versi dasar dari _Advanced Expense List_.                                          |

---

## 🖼️ Screenshot & Deskripsi Setiap Halaman

---

### 🧠 About Screen  
Menampilkan informasi tentang aplikasi, tujuan pembuatannya, serta identitas pengembang.  
Biasanya berisi versi aplikasi dan deskripsi singkat proyek.  
![About Screen](screenshots/expense_tracker/about_screen.png)

---

### 🧾 Add Expense Screen  
Formulir untuk menambahkan data pengeluaran baru.  
Pengguna dapat mengisi kategori, nominal, tanggal, dan deskripsi pengeluaran.  
- 🔘 **Simpan:** Menyimpan data pengeluaran ke dalam sistem.  
- 🔘 **Batal:** Kembali tanpa menyimpan data.  
![Add Expense Screen](screenshots/expense_tracker/add_expense_screen.png)

---

### 💼 Advanced Expense List Screen  
Menampilkan daftar pengeluaran lengkap dengan fitur **cari, tambah, edit, dan hapus**.  
- ➕ **Tambah:** Membuka form tambah pengeluaran.  
- ✏️ **Edit:** Mengubah detail pengeluaran tertentu.  
- 🗑️ **Hapus:** Menghapus pengeluaran dari daftar.  
- 🔁 **Refresh:** Memuat ulang daftar pengeluaran.  
![Advanced Expense List Screen](screenshots/expense_tracker/advanced_expense_list_screen.png)

---

### 🗂️ Category Screen  
Mengelola kategori pengeluaran yang dapat digunakan saat input data.  
- ➕ **Tambah Kategori:** Menambahkan kategori baru.  
- 🗑️ **Hapus Kategori:** Menghapus kategori yang tidak digunakan.  
![Category Screen](screenshots/expense_tracker/category_screen.png)

---

### ✏️ Edit Expense Screen  
Formulir untuk memperbarui data pengeluaran yang sudah tersimpan.  
- 🔘 **Simpan:** Menyimpan perubahan pada pengeluaran.  
- 🔘 **Batal:** Membatalkan perubahan.  
![Edit Expense Screen](screenshots/expense_tracker/edit_expense_screen.png)

---

### 👤 Edit Profile Screen  
Formulir untuk memperbarui profil pengguna seperti nama, email, dan foto profil.  
- 🔘 **Simpan:** Menyimpan perubahan profil.  
- 🔘 **Batal:** Membatalkan perubahan.  
![Edit Profile Screen](screenshots/expense_tracker/edit_profile_screen.png)

---

### 🏠 Home Screen  
Halaman utama setelah login. Menampilkan sapaan pengguna, total pengeluaran, dan menu cepat ke fitur lain.  
- 🏷️ **Menu Grid:** Navigasi cepat ke Statistik, Kategori, Profil, Pengaturan, dan Posts.  
- 🔘 **Logout:** Keluar dari aplikasi.  
![Home Screen](screenshots/expense_tracker/home_screen.png)

---

### 🔐 Login Screen  
Halaman untuk masuk ke aplikasi menggunakan email dan password.  
- 🔘 **Login:** Memverifikasi dan masuk ke aplikasi.  
- 🔘 **Daftar:** Arahkan ke halaman Register.  
![Login Screen](screenshots/expense_tracker/login_screen.png)

---

### ☁️ Posts Screen  
Menampilkan daftar postingan dari API eksternal (`jsonplaceholder.typicode.com`).  
- ➕ **Tambah:** Membuat posting baru ke API.  
- 🗑️ **Hapus:** Menghapus posting yang dipilih.  
- 🔁 **Refresh:** Memuat ulang daftar posting.  
![Posts Screen](screenshots/expense_tracker/posts_screen.png)

---

### 👥 Profile Screen  
Menampilkan profil pengguna yang sedang login.  
- ✏️ **Edit Profil:** Membuka form edit profil.  
- 🔘 **Logout:** Keluar dari akun.  
![Profile Screen](screenshots/expense_tracker/profile_screen.png)

---

### 📝 Register Screen  
Form pendaftaran untuk pengguna baru.  
- 🔘 **Daftar:** Membuat akun baru.  
- 🔘 **Login:** Kembali ke halaman login.  
![Register Screen](screenshots/expense_tracker/register_screen.png)

---

### ⚙️ Settings Screen  
Halaman pengaturan aplikasi seperti tema, bahasa, notifikasi, dan informasi versi.  
- 🔘 **Tentang Aplikasi:** Menuju halaman *About*.  
- 🔘 **Notifikasi:** Mengaktifkan atau menonaktifkan notifikasi.  
![Settings Screen](screenshots/expense_tracker/settings_screen.png)

---

### 📊 Statistics Screen  
Menampilkan grafik dan ringkasan statistik pengeluaran pengguna.  
Bisa difilter berdasarkan harian, mingguan, bulanan, atau kategori.  
- 🔘 **Filter:** Menyaring data berdasarkan waktu atau kategori.  
- 🔁 **Refresh:** Memperbarui data statistik.  
![Statistics Screen](screenshots/expense_tracker/statistics_screen.png)

---