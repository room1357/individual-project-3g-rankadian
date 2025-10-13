import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../models/category.dart';
import '../services/expense_service.dart';
import '../utils/currency_utils.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String _selectedRange = 'bulanan';
  DateTimeRange? _customRange;

  @override
  Widget build(BuildContext context) {
    final filteredExpenses = _getFilteredExpenses;
    final totalAmount = filteredExpenses.fold<double>(0, (sum, e) => sum + e.amount);
    final totalsByCategory = ExpenseService.getTotalByCategoryFiltered(filteredExpenses);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik Pengeluaran'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePdfReport(filteredExpenses),
            tooltip: 'Export ke PDF',
          ),
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
            // 🔹 Filter Rentang Waktu
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedRange,
                    items: const [
                      DropdownMenuItem(value: 'harian', child: Text('Harian')),
                      DropdownMenuItem(value: 'mingguan', child: Text('Mingguan')),
                      DropdownMenuItem(value: 'bulanan', child: Text('Bulanan')),
                      DropdownMenuItem(value: 'custom', child: Text('Custom Range')),
                    ],
                    onChanged: (value) async {
                      if (value == 'custom') {
                        final picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2023),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() => _customRange = picked);
                        }
                      }
                      setState(() => _selectedRange = value!);
                    },
                  ),
                ),
                if (_selectedRange == 'custom' && _customRange != null)
                  Text(
                    "${DateFormat('dd MMM').format(_customRange!.start)} - ${DateFormat('dd MMM yyyy').format(_customRange!.end)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // 🔹 Total Ringkasan
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Total Pengeluaran',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      CurrencyUtils.formatCurrency(totalAmount),
                      style: const TextStyle(
                          fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    Text('Jumlah Item: ${filteredExpenses.length}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Per Kategori:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // 🔹 Daftar Per Kategori
            Expanded(
              child: totalsByCategory.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada data untuk rentang waktu ini.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: totalsByCategory.length,
                      itemBuilder: (context, index) {
                        final categoryId = totalsByCategory.keys.elementAt(index);
                        final amount = totalsByCategory[categoryId]!;
                        final categoryName = ExpenseService.categories
                            .firstWhere(
                              (cat) => cat.id == categoryId,
                              orElse: () => Category(id: '', name: 'Unknown'),
                            )
                            .name;

                        return Card(
                          child: ListTile(
                            title: Text(categoryName),
                            trailing: Text(
                              CurrencyUtils.formatCurrency(amount),
                              style: const TextStyle(fontWeight: FontWeight.bold),
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

  // 🔹 Filter berdasarkan pilihan rentang waktu
  List get _getFilteredExpenses {
    final all = ExpenseService.getAllExpenses();
    final now = DateTime.now();

    DateTime start;
    DateTime end = now;

    switch (_selectedRange) {
      case 'harian':
        start = DateTime(now.year, now.month, now.day);
        break;
      case 'mingguan':
        start = now.subtract(const Duration(days: 7));
        break;
      case 'bulanan':
        start = DateTime(now.year, now.month, 1);
        break;
      case 'custom':
        if (_customRange != null) {
          start = _customRange!.start;
          end = _customRange!.end;
        } else {
          start = DateTime(now.year, now.month, 1);
        }
        break;
      default:
        start = DateTime(now.year, now.month, 1);
    }

    return all.where((e) => e.date.isAfter(start) && e.date.isBefore(end)).toList();
  }

  // 🔹 Export CSV (fitur lama kamu tetap dipakai)
  void _showExportDialog() {
    final csvContent = ExpenseService.exportToCSV();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data ke CSV'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: SingleChildScrollView(
            child: SelectableText(
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
        ],
      ),
    );
  }

  // 🔹 Export PDF
  Future<void> _generatePdfReport(List expenses) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Center(
            child: pw.Text('Laporan Pengeluaran ($_selectedRange)',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 20),
          pw.TableHelper.fromTextArray(
            headers: ['Tanggal', 'Judul', 'Kategori', 'Jumlah'],
            data: expenses.map((e) {
              return [
                DateFormat('dd/MM/yyyy').format(e.date),
                e.title,
                e.categoryName,
                CurrencyUtils.formatCurrency(e.amount),
              ];
            }).toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 10),
            cellAlignment: pw.Alignment.centerLeft,
          ),
          pw.Divider(),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              'Total: ${CurrencyUtils.formatCurrency(expenses.fold(0, (sum, e) => sum + e.amount))}',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }
}
