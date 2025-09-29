import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/expense_service.dart';
import '../utils/currency_utils.dart';
import 'add_expense_screen.dart';
import 'edit_expense_screen.dart';

class AdvancedExpenseListScreen extends StatefulWidget {
  const AdvancedExpenseListScreen({super.key});

  @override
  State<AdvancedExpenseListScreen> createState() =>
      _AdvancedExpenseListScreenState();
}

class _AdvancedExpenseListScreenState extends State<AdvancedExpenseListScreen> {
  // Menggunakan data dari ExpenseService (dinamis)
  List<Expense> expenses = [];
  List<Expense> filteredExpenses = [];
  String selectedCategory = 'Semua'; // Default filter kategori
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshExpenses(); // Inisialisasi dengan data dari service
    searchController.addListener(_filterExpenses); // Dengarkan perubahan pada search bar
  }

  @override
  void dispose() {
    searchController.removeListener(_filterExpenses);
    searchController.dispose();
    super.dispose();
  }

  // Method baru: Refresh data dari service dan filter ulang
  void _refreshExpenses() {
    setState(() {
      expenses = List.from(ExpenseService.expenses); // Ambil data terbaru
      _filterExpenses(); // Filter ulang berdasarkan search dan category
    });
  }

  // Fungsi untuk memfilter pengeluaran berdasarkan search query dan kategori (update untuk categoryName)
  void _filterExpenses() {
    setState(() {
      filteredExpenses = expenses.where((expense) {
        bool matchesSearch = searchController.text.isEmpty ||
            expense.title.toLowerCase().contains(searchController.text.toLowerCase()) ||
            expense.description.toLowerCase().contains(searchController.text.toLowerCase());

        bool matchesCategory = selectedCategory == 'Semua' ||
            expense.categoryName == selectedCategory; // Ganti dari expense.category ke categoryName

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  // Method untuk konfirmasi delete (baru, untuk fitur delete)
  Future<void> _confirmDelete(String id, String title) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Pengeluaran?'),
        content: Text('Apakah Anda yakin ingin menghapus "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      ExpenseService.deleteExpense(id);
      _refreshExpenses(); // Refresh data dari service
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pengeluaran "$title" dihapus!')),
      );
    }
  }

  // Method untuk menghitung total menggunakan fold() (update format opsional)
  String _calculateTotal(List<Expense> expensesToCalculate) {
    double total = expensesToCalculate.fold(0, (sum, expense) => sum + expense.amount);
    return CurrencyUtils.formatCurrency(total); // Gunakan utils jika ada, atau 'Rp ${total.toStringAsFixed(0)}'
  }

  // Method untuk menghitung rata-rata (update format opsional)
  String _calculateAverage(List<Expense> expensesToCalculate) {
    if (expensesToCalculate.isEmpty) return CurrencyUtils.formatCurrency(0); // Atau 'Rp 0'
    double total = expensesToCalculate.fold(0, (sum, expense) => sum + expense.amount);
    double average = total / expensesToCalculate.length;
    return CurrencyUtils.formatCurrency(average); // Atau 'Rp ${average.toStringAsFixed(0)}'
  }

  // Method untuk mendapatkan warna berdasarkan kategori (update untuk categoryName, opsional gunakan expense.categoryColor)
  Color _getCategoryColor(String categoryName) {
    switch (categoryName.toLowerCase()) {
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
    // Opsional: Jika model Expense punya getter categoryColor, return expense.categoryColor;
  }

  // Method untuk mendapatkan icon berdasarkan kategori (update untuk categoryName, opsional gunakan expense.categoryIcon)
  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
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
    // Opsional: Jika model Expense punya getter categoryIcon, return expense.categoryIcon;
  }

  // Method untuk menampilkan detail pengeluaran dalam dialog (update untuk categoryName)
  void _showExpenseDetails(BuildContext context, Expense expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(expense.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jumlah: ${expense.formattedAmount}'),
            const SizedBox(height: 8),
            Text('Kategori: ${expense.categoryName}'), // Ganti dari expense.category
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

  // Widget pembantu untuk kartu statistik (tetap sama)
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
    // Mendapatkan daftar kategori unik dari data expenses (update untuk categoryName)
    Set<String> uniqueCategories = {'Semua'};
    uniqueCategories.addAll(expenses.map((e) => e.categoryName)); // Ganti dari e.category

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengeluaran Advanced'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search bar (tetap sama)
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
          // Category filter (tetap sama, tapi data dari uniqueCategories yang diupdate)
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: uniqueCategories
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
          // Statistics summary (tetap sama)
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Total', _calculateTotal(filteredExpenses)),
                _buildStatCard('Jumlah', '${filteredExpenses.length} item'),
                _buildStatCard('Rata-rata', _calculateAverage(filteredExpenses)),
              ],
            ),
          ),
          // Expense list (update trailing untuk edit/delete, leading untuk categoryName)
          Expanded(
            child: filteredExpenses.isEmpty
                ? const Center(child: Text('Tidak ada pengeluaran ditemukan'))
                : ListView.builder(
                    itemCount: filteredExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = filteredExpenses[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _getCategoryColor(expense.categoryName), // Update argumen
                            child: Icon(
                              _getCategoryIcon(expense.categoryName), // Update argumen
                              color: Colors.white,
                            ),
                          ),
                          title: Text(expense.title),
                          subtitle: Text('${expense.categoryName} - ${expense.formattedDate}'), // Update ke categoryName
                          trailing: Row( // Update: Tambah edit/delete di samping amount
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Amount (seperti existing)
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  expense.formattedAmount,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[600],
                                  ),
                                ),
                              ),
                              // Tombol Edit (baru)
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditExpenseScreen(expense: expense),
                                    ),
                                  ).then((_) => _refreshExpenses()); // Refresh setelah edit
                                },
                                tooltip: 'Edit',
                              ),
                              // Tombol Delete (baru)
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDelete(expense.id, expense.title),
                                tooltip: 'Hapus',
                              ),
                            ],
                          ),
                          onTap: () => _showExpenseDetails(context, expense), // Tetap untuk detail
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      // Tambahkan FAB untuk add expense (baru)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          ).then((_) => _refreshExpenses()); // Refresh setelah add
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}