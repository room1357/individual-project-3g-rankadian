import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/expense_service.dart';
import '../utils/currency_utils.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    final totalAmount = ExpenseService.getTotalAmount();
    final expenseCount = ExpenseService.getExpenseCount();
    final totalsByCategory = ExpenseService.getTotalByCategory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik Pengeluaran'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _showExportDialog,
            tooltip: 'Export ke CSV',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Total Pengeluaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      CurrencyUtils.formatCurrency(totalAmount),
                      style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold), // Tambah bold
                    ),
                    Text('Jumlah Item: $expenseCount', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Per Kategori:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: totalsByCategory.isEmpty // Tambahkan penanganan jika kosong
                  ? const Center(
                      child: Text(
                        'Belum ada data pengeluaran. Tambahkan expense terlebih dahulu!',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: totalsByCategory.length,
                      itemBuilder: (context, index) {
                        final categoryId = totalsByCategory.keys.elementAt(index);
                        final amount = totalsByCategory[categoryId]!;
                        final categoryName = ExpenseService.categories.firstWhere(
                          (cat) => cat.id == categoryId,
                          orElse: () => Category(id: '', name: 'Unknown'), // Sekarang aman karena Category di-import
                        ).name;

                        return Card(
                          child: ListTile(
                            title: Text(categoryName),
                            trailing: Text(
                              CurrencyUtils.formatCurrency(amount),
                              style: const TextStyle(fontWeight: FontWeight.bold), // Tambah bold untuk konsistensi
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // method ini untuk dialog export CSV (fitur 4.5)
  void _showExportDialog() {
    final csvContent = ExpenseService.exportToCSV();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data ke CSV'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300, // Batasi tinggi dialog agar tidak terlalu panjang
          child: SingleChildScrollView(
            child: SelectableText( // Buat text bisa di-select/copy
              csvContent,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          // Opsional: Jika ingin tombol copy (butuh import 'package:flutter/services.dart'; di atas)
          // ElevatedButton(
          //   onPressed: () {
          //     Clipboard.setData(ClipboardData(text: csvContent));
          //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('CSV disalin ke clipboard!')));
          //     Navigator.pop(context);
          //   },
          //   child: const Text('Copy'),
          // ),
        ],
      ),
    );
  }
}