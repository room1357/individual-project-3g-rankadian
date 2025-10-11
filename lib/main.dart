import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/expense_service.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Inisialisasi data yang disimpan (expenses & users)
  ExpenseService.initialize();
  await AuthService().init();

  // 🔹 Cek status login terakhir dari SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final loggedInUser = prefs.getString('loggedInUser');

  runApp(MyApp(isLoggedIn: loggedInUser != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Pengeluaran Extended',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // 🔹 Jika sudah login → HomeScreen, jika belum → LoginScreen
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
