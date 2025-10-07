// import 'package:flutter/material.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login'), backgroundColor: Colors.blue),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Logo
//             Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.person, size: 50, color: Colors.white),
//             ),
//             SizedBox(height: 32),

//             // Username Field
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Username',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.person),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Password Field
//             TextField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.lock),
//               ),
//             ),
//             SizedBox(height: 24),

//             // Login Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle login
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 child: Text(
//                   'LOGIN',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Register Link
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Don't have an account? "),
//                 TextButton(
//                   onPressed: () {
//                     // Navigate to register
//                   },
//                   child: Text('Register'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'register_screen.dart';
// import 'home_screen.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Masuk'), backgroundColor: Colors.blue),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Logo aplikasi
//             Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.person, size: 50, color: Colors.white),
//             ),
//             SizedBox(height: 32),

//             // Field username
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Username',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.person),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Field password
//             TextField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.lock),
//               ),
//             ),
//             SizedBox(height: 24),

//             // Tombol login
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Navigasi ke HomeScreen dengan pushReplacement
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => const HomeScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 child: Text(
//                   'MASUK',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Link ke halaman register
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Belum punya akun? "),
//                 TextButton(
//                   onPressed: () {
//                     // Navigasi ke RegisterScreen dengan push
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const RegisterScreen(),
//                       ),
//                     );
//                   },
//                   child: Text('Daftar'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isi semua kolom terlebih dahulu')),
      );
      return;
    }

    setState(() => _loading = true);

    final success = await AuthService().login(email, password);

    setState(() => _loading = false);

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Masuk'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo aplikasi
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 32),

            // Field email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),

            // Field password
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol login
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'MASUK',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Link ke halaman register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Belum punya akun? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('Daftar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
