// import 'package:flutter/material.dart';
// import 'login_screen.dart';
// import 'advanced_expense_list_screen.dart';
// import 'profile_screen.dart'; 
// import 'settings_screen.dart'; 
// // import 'add_expense_screen.dart';
// import 'category_screen.dart';
// import 'statistics_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Beranda'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 (route) => false,
//               );
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Dashboard',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 children: [
//                   _buildDashboardCard(
//                     'Pengeluaran',
//                     Icons.attach_money,
//                     Colors.green,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const AdvancedExpenseListScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   _buildDashboardCard('Profil', Icons.person, Colors.blue, () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ProfileScreen(),
//                       ),
//                     );
//                   }),
//                   _buildDashboardCard(
//                     'Pesan',
//                     Icons.message,
//                     Colors.orange,
//                     null,
//                   ),
//                   _buildDashboardCard(
//                     'Pengaturan',
//                     Icons.settings,
//                     Colors.purple,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SettingsScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   // _buildDashboardCard(
//                   //   'Tambah Pengeluaran',
//                   //   Icons.add,
//                   //   Colors.teal,
//                   //   () {
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (context) => const AddExpenseScreen(),
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//                   _buildDashboardCard(
//                     'Kelola Kategori',
//                     Icons.category,
//                     Colors.indigo,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const CategoryScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   _buildDashboardCard(
//                     'Statistik',
//                     Icons.bar_chart,
//                     Colors.amber, // Warna kuning untuk analisis
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const StatisticsScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   // jika ingin card Export (bisa dihapus jika tidak perlu)
//                   // _buildDashboardCard(
//                   //   'Export Data',
//                   //   Icons.download,
//                   //   Colors.red,
//                   //   () {
//                   //     // Panggil dialog export langsung dari sini (seperti di StatisticsScreen)
//                   //     final csvContent = ExpenseService.exportToCSV();
//                   //     showDialog(
//                   //       context: context,
//                   //       builder: (context) => AlertDialog(
//                   //         title: const Text('Export CSV'),
//                   //         content: SingleChildScrollView(child: SelectableText(csvContent)),
//                   //         actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))],
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardCard(
//     String title,
//     IconData icon,
//     Color color,
//     VoidCallback? onTap,
//   ) {
//     return Card(
//       elevation: 4,
//       child: Builder(
//         builder: (context) => InkWell(
//           onTap: onTap ??
//               () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Fitur $title segera hadir!')),
//                 );
//               },
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, size: 48, color: color),
//                 const SizedBox(height: 12),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'advanced_expense_list_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'category_screen.dart';
import 'statistics_screen.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    final user = AuthService().currentUser;
    if (user != null) {
      userName = user.name;
    }
  }

  void _logout() async {
    await AuthService().logout();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda ${userName.isNotEmpty ? "- $userName" : ""}'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang, ${userName.isNotEmpty ? userName : "Pengguna"}!',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    'Pengeluaran',
                    Icons.attach_money,
                    Colors.green,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdvancedExpenseListScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard('Profil', Icons.person, Colors.blue, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  }),
                  _buildDashboardCard(
                    'Pesan',
                    Icons.message,
                    Colors.orange,
                    null,
                  ),
                  _buildDashboardCard(
                    'Pengaturan',
                    Icons.settings,
                    Colors.purple,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    'Kelola Kategori',
                    Icons.category,
                    Colors.indigo,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CategoryScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    'Statistik',
                    Icons.bar_chart,
                    Colors.amber,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StatisticsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback? onTap,
  ) {
    return Card(
      elevation: 4,
      child: Builder(
        builder: (context) => InkWell(
          onTap: onTap ??
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fitur $title segera hadir!')),
                );
              },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: color),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
