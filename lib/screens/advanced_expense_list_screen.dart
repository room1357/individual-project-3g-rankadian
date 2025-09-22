import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/expense_manager.dart'; // Import ExpenseManager

class AdvancedExpenseListScreen extends StatefulWidget {
  const AdvancedExpenseListScreen({super.key});

  @override
  State<AdvancedExpenseListScreen> createState() =>
      _AdvancedExpenseListScreenState();
}

class _AdvancedExpenseListScreenState extends State<AdvancedExpenseListScreen> {
  // Menggunakan data dari ExpenseManager
  List<Expense> expenses = ExpenseManager.expenses;
  List<Expense> filteredExpenses = [];
  String selectedCategory = 'Semua'; // Default filter kategori
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredExpenses = List.from(
      expenses,
    ); // Inisialisasi dengan semua pengeluaran
    searchController.addListener(
      _filterExpenses,
    ); // Dengarkan perubahan pada search bar
  }

  @override
  void dispose() {
    searchController.removeListener(_filterExpenses);
    searchController.dispose();
    super.dispose();
  }

  // Fungsi untuk memfilter pengeluaran berdasarkan search query dan kategori
  void _filterExpenses() {
    setState(() {
      filteredExpenses =
          expenses.where((expense) {
            bool matchesSearch =
                searchController.text.isEmpty ||
                expense.title.toLowerCase().contains(
                  searchController.text.toLowerCase(),
                ) ||
                expense.description.toLowerCase().contains(
                  searchController.text.toLowerCase(),
                );

            bool matchesCategory =
                selectedCategory == 'Semua' ||
                expense.category == selectedCategory;

            return matchesSearch && matchesCategory;
          }).toList();
    });
  }

  // Method untuk menghitung total menggunakan fold()
  String _calculateTotal(List<Expense> expensesToCalculate) {
    double total = expensesToCalculate.fold(
      0,
      (sum, expense) => sum + expense.amount,
    );
    return 'Rp ${total.toStringAsFixed(0)}';
  }

  // Method untuk menghitung rata-rata
  String _calculateAverage(List<Expense> expensesToCalculate) {
    if (expensesToCalculate.isEmpty) return 'Rp 0';
    double total = expensesToCalculate.fold(
      0,
      (sum, expense) => sum + expense.amount,
    );
    double average = total / expensesToCalculate.length;
    return 'Rp ${average.toStringAsFixed(0)}';
  }

  // Method untuk mendapatkan warna berdasarkan kategori (dari ExpenseListScreen sebelumnya)
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return Colors.orange;
      case 'transportasi':
        return Colors.green;
      case 'utilitas':
        return Colors.purple;
      case 'hiburan':
        return Colors.pink;
      case 'pendidikan':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  // Method untuk mendapatkan icon berdasarkan kategori (dari ExpenseListScreen sebelumnya)
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return Icons.restaurant;
      case 'transportasi':
        return Icons.directions_car;
      case 'utilitas':
        return Icons.home;
      case 'hiburan':
        return Icons.movie;
      case 'pendidikan':
        return Icons.school;
      default:
        return Icons.attach_money;
    }
  }

  // Method untuk menampilkan detail pengeluaran dalam dialog
  void _showExpenseDetails(BuildContext context, Expense expense) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(expense.title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jumlah: ${expense.formattedAmount}'),
                const SizedBox(height: 8),
                Text('Kategori: ${expense.category}'),
                const SizedBox(height: 8),
                Text('Tanggal: ${expense.formattedDate}'),
                const SizedBox(height: 8),
                Text('Deskripsi: ${expense.description}'),
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

  // Widget pembantu untuk kartu statistik
  Widget _buildStatCard(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan daftar kategori unik dari data expenses
    Set<String> uniqueCategories = {'Semua'};
    uniqueCategories.addAll(expenses.map((e) => e.category));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengeluaran Advanced'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Cari pengeluaran...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              // onChanged sudah diatur di initState melalui addListener
            ),
          ),
          // Category filter
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children:
                  uniqueCategories
                      .map(
                        (category) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(category),
                            selected: selectedCategory == category,
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = category;
                                _filterExpenses(); // Panggil filter saat kategori berubah
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          // Statistics summary
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Total', _calculateTotal(filteredExpenses)),
                _buildStatCard('Jumlah', '${filteredExpenses.length} item'),
                _buildStatCard(
                  'Rata-rata',
                  _calculateAverage(filteredExpenses),
                ),
              ],
            ),
          ),
          // Expense list
          Expanded(
            child:
                filteredExpenses.isEmpty
                    ? const Center(
                      child: Text('Tidak ada pengeluaran ditemukan'),
                    )
                    : ListView.builder(
                      itemCount: filteredExpenses.length,
                      itemBuilder: (context, index) {
                        final expense = filteredExpenses[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getCategoryColor(
                                expense.category,
                              ),
                              child: Icon(
                                _getCategoryIcon(expense.category),
                                color: Colors.white,
                              ),
                            ),
                            title: Text(expense.title),
                            subtitle: Text(
                              '${expense.category} - ${expense.formattedDate}',
                            ),
                            trailing: Text(
                              expense.formattedAmount,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[600],
                              ),
                            ),
                            onTap: () => _showExpenseDetails(context, expense),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
