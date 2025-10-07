import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar'), backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person_add, size: 50, color: Colors.white),
            ),
            SizedBox(height: 32),

            // Full Name Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),

            // Email Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16),

            // Username Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_circle),
              ),
            ),
            SizedBox(height: 16),

            // Password Field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 16),

            // Confirm Password Field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            SizedBox(height: 24),

            // Register Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle register
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'DAFTAR',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah punya akun? "),
                TextButton(
                  onPressed: () {
                    // Navigate to login
                  },
                  child: Text('Masuk'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'home_screen.dart';

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
//             // Form fields...

//             // Tombol register
//             ElevatedButton(
//               onPressed: () {
//                 // Navigasi ke HomeScreen dengan pushReplacement
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HomeScreen()),
//                 );
//               },
//               child: Text('DAFTAR'),
//             ),

//             // Link kembali ke login
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Kembali ke LoginScreen
//               },
//               child: Text('Sudah punya akun? Masuk'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
