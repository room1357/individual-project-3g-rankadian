import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'about_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  // bool _darkModeEnabled = false;
  String _language = 'Indonesia';
  String _appVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      // _darkModeEnabled = prefs.getBool('darkModeEnabled') ?? false;
      _language = prefs.getString('language') ?? 'Indonesia';
    });

    final info = await PackageInfo.fromPlatform();
    setState(() => _appVersion = info.version);
  }

  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
    setState(() => _notificationsEnabled = value);
  }

  // Future<void> _toggleDarkMode(bool value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('darkModeEnabled', value);
  //   if (!mounted) return;
  //   setState(() => _darkModeEnabled = value);

  //   final themeMode = value ? ThemeMode.dark : ThemeMode.light;
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder:
  //           (_) => MaterialApp(
  //             theme: ThemeData.light(),
  //             darkTheme: ThemeData.dark(),
  //             themeMode: themeMode,
  //             home: const SettingsScreen(),
  //           ),
  //     ),
  //   );
  // }

  Future<void> _changeLanguage(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Pilih Bahasa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('Indonesia'),
              onTap: () => Navigator.pop(context, 'Indonesia'),
            ),
            ListTile(
              title: const Text('English'),
              onTap: () => Navigator.pop(context, 'English'),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );

    if (selected != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', selected);
      if (!mounted) return;
      setState(() => _language = selected);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('Bahasa diubah ke $selected')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final themeColor = _darkModeEnabled ? Colors.grey[900] : Colors.white;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Notifikasi'),
            value: _notificationsEnabled,
            onChanged: _toggleNotifications,
          ),
          // SwitchListTile(
          //   title: const Text('Mode Gelap'),
          //   value: _darkModeEnabled,
          //   onChanged: _toggleDarkMode,
          // ),
          ListTile(
            title: const Text('Bahasa'),
            subtitle: Text(_language),
            onTap: () => _changeLanguage(context),
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
            subtitle: Text(_appVersion),
          ),
        ],
      ),
    );
  }
}
