import 'package:flutter/material.dart';
import 'about_screen.dart'; // Import AboutScreen

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // ListTile(
          //   title: const Text('Notifikasi'),
          //   trailing: Switch(value: true, onChanged: (bool value) {}),
          // ),
          ListTile(
            title: const Text('Bahasa'),
            subtitle: const Text('Indonesia'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur bahasa segera hadir!')),
              );
            },
          ),
          ListTile(
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Versi Aplikasi'),
            subtitle: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
