import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aplikasi Pengelola Pengeluaran',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Text(
              'Aplikasi ini membantu Anda melacak dan mengelola pengeluaran harian Anda dengan mudah.',
              style: TextStyle(fontSize: 16),
            ),
            Text('', style: TextStyle(fontSize: 16)),
            Text(
              'Dibuat Oleh Evan Diantha Fafian dari Jurusan Teknologi Informasi, Program Studi Sistem Informasi Bisnis, Politeknik Negeri Malang.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
