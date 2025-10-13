import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Expense> expenses = [
      Expense(
        id: '1',
        title: 'Belanja Bulanan',
        amount: 150000,
        categoryId: '1', // Makanan
        date: DateTime(2024, 9, 15),
        description: 'Belanja kebutuhan bulanan di supermarket',
      ),
      Expense(
        id: '2',
        title: 'Bensin Motor',
        amount: 50000,
        categoryId: '2', // Transportasi
        date: DateTime(2024, 9, 14),
        description: 'Isi bensin motor untuk transportasi',
      ),
      Expense(
        id: '3',
        title: 'Kopi di Cafe',
        amount: 25000,
        categoryId: '1', // Makanan
        date: DateTime(2024, 9, 14),
        description: 'Ngopi pagi dengan teman',
      ),
      Expense(
        id: '4',
        title: 'Tagihan Internet',
        amount: 300000,
        categoryId: '3', // Utilitas
        date: DateTime(2024, 9, 13),
        description: 'Tagihan internet bulanan',
      ),
      Expense(
        id: '5',
        title: 'Tiket Bioskop',
        amount: 100000,
        categoryId: '4', // Hiburan
        date: DateTime(2024, 9, 12),
        description: 'Nonton film weekend bersama keluarga',
      ),
      Expense(
        id: '6',
        title: 'Beli Buku',
        amount: 75000,
        categoryId: '5', // Pendidikan
        date: DateTime(2024, 9, 11),
        description: 'Buku pemrograman untuk belajar',
      ),
      Expense(
        id: '7',
        title: 'Makan Siang',
        amount: 35000,
        categoryId: '1', // Makanan
        date: DateTime(2024, 9, 11),
        description: 'Makan siang di restoran',
      ),
      Expense(
        id: '8',
        title: 'Ongkos Bus',
        amount: 10000,
        categoryId: '2', // Transportasi
        date: DateTime(2024, 9, 10),
        description: 'Ongkos perjalanan harian ke kampus',
      ),
    ];

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
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_rounded),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Daftar Pengeluaran',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Total Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF667eea),
                              const Color(0xFF764ba2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF667eea,
                              ).withValues(alpha: 0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Pengeluaran',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _calculateTotal(expenses),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
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
                              child: const Icon(
                                Icons.account_balance_wallet_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // List Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 20,
                              decoration: BoxDecoration(
                                color: const Color(0xFF667eea),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Riwayat Transaksi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF667eea,
                                ).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${expenses.length} items',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF667eea),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Expense List
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(
                                      expense.categoryName,
                                    ).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    _getCategoryIcon(expense.categoryName),
                                    color: _getCategoryColor(
                                      expense.categoryName,
                                    ),
                                    size: 28,
                                  ),
                                ),
                                title: Text(
                                  expense.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      expense.categoryName,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      expense.formattedDate,
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  expense.formattedAmount,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.red.shade600,
                                  ),
                                ),
                                onTap: () {
                                  _showExpenseDetails(context, expense);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Fitur tambah pengeluaran segera hadir!'),
              backgroundColor: const Color(0xFF667eea),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
        backgroundColor: const Color(0xFF667eea),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'Tambah',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Method untuk menghitung total menggunakan fold()
  String _calculateTotal(List<Expense> expenses) {
    double total = expenses.fold(0, (sum, expense) => sum + expense.amount);
    return 'Rp ${total.toStringAsFixed(0)}';
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return const Color(0xFFff6b6b);
      case 'transportasi':
        return const Color(0xFF4ecdc4);
      case 'utilitas':
        return const Color(0xFF95e1d3);
      case 'hiburan':
        return const Color(0xFFf38181);
      case 'pendidikan':
        return const Color(0xFF667eea);
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return Icons.restaurant_rounded;
      case 'transportasi':
        return Icons.directions_car_rounded;
      case 'utilitas':
        return Icons.home_rounded;
      case 'hiburan':
        return Icons.movie_rounded;
      case 'pendidikan':
        return Icons.school_rounded;
      default:
        return Icons.attach_money;
    }
  }

  void _showExpenseDetails(BuildContext context, Expense expense) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getCategoryColor(expense.categoryName),
                  child: Icon(
                    _getCategoryIcon(expense.categoryName),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    expense.title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  'Jumlah',
                  expense.formattedAmount,
                  Icons.payments_rounded,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Kategori',
                  expense.categoryName,
                  Icons.category_rounded,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Tanggal',
                  expense.formattedDate,
                  Icons.calendar_today_rounded,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Deskripsi',
                  expense.description,
                  Icons.description_rounded,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup'),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF667eea)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
