// import 'package:flutter/material.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Daftar'), backgroundColor: Colors.blue),
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
//               child: Icon(Icons.person_add, size: 50, color: Colors.white),
//             ),
//             SizedBox(height: 32),

//             // Full Name Field
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Nama',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.person),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Email Field
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.email),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Username Field
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Username',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.account_circle),
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
//             SizedBox(height: 16),

//             // Confirm Password Field
//             TextField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Confirm Password',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.lock_outline),
//               ),
//             ),
//             SizedBox(height: 24),

//             // Register Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle register
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 child: Text(
//                   'DAFTAR',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Login Link
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Sudah punya akun? "),
//                 TextButton(
//                   onPressed: () {
//                     // Navigate to login
//                   },
//                   child: Text('Masuk'),
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
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _loading = false;

  void _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isi semua kolom terlebih dahulu')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konfirmasi password tidak cocok')),
      );
      return;
    }

    setState(() => _loading = true);

    final success = await AuthService().register(email, name, password);

    setState(() => _loading = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email sudah digunakan!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.person_add, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 32),

              // Nama
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),

              // Email
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),

              // Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16),

              // Konfirmasi password
              TextField(
                controller: _confirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 24),

              // Tombol daftar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'DAFTAR',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Link ke login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sudah punya akun? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text('Masuk'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
