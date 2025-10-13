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
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Konfirmasi Logout'),
            content: const Text('Apakah Anda yakin ingin keluar?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF667eea),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await AuthService().logout();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, ${userName.isNotEmpty ? userName : "Pengguna"}! 👋',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Selamat datang kembali',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      child: IconButton(
                        onPressed: _logout,
                        icon: const Icon(Icons.logout_rounded),
                        color: Colors.white,
                        tooltip: 'Logout',
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFF667eea),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Menu Utama',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2d3748),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.0,
                            children: [
                              _buildModernCard(
                                'Pengeluaran',
                                Icons.account_balance_wallet_rounded,
                                const Color(0xFF667eea),
                                const Color(0xFF764ba2),
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const AdvancedExpenseListScreen(),
                                    ),
                                  );
                                },
                              ),
                              _buildModernCard(
                                'Profil',
                                Icons.person_rounded,
                                const Color(0xFF00d2ff),
                                const Color(0xFF3a7bd5),
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const ProfileScreen(),
                                    ),
                                  );
                                },
                              ),
                              _buildModernCard(
                                'Statistik',
                                Icons.bar_chart_rounded,
                                const Color(0xFFf093fb),
                                const Color(0xFFf5576c),
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const StatisticsScreen(),
                                    ),
                                  );
                                },
                              ),
                              _buildModernCard(
                                'Kategori',
                                Icons.category_rounded,
                                const Color(0xFF4facfe),
                                const Color(0xFF00f2fe),
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const CategoryScreen(),
                                    ),
                                  );
                                },
                              ),
                              _buildModernCard(
                                'Pesan',
                                Icons.chat_bubble_rounded,
                                const Color(0xFFfa709a),
                                const Color(0xFFfee140),
                                null,
                              ),
                              _buildModernCard(
                                'Pengaturan',
                                Icons.settings_rounded,
                                const Color(0xFF30cfd0),
                                const Color(0xFF330867),
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const SettingsScreen(),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernCard(
    String title,
    IconData icon,
    Color startColor,
    Color endColor,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Fitur $title segera hadir!'),
                backgroundColor: startColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [startColor, endColor],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: startColor.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap:
                onTap ??
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Fitur $title segera hadir!'),
                      backgroundColor: startColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(icon, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
