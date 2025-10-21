import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
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

  Color _getCategoryColor(String categoryName) {
    switch (categoryName.toLowerCase()) {
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
        return const Color(0xFF667eea);
    }
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
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
        return Icons.category_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredExpenses = _getFilteredExpenses;
    final totalAmount = filteredExpenses.fold<double>(
      0,
      (sum, e) => sum + e.amount,
    );
    final totalsByCategory = ExpenseService.getTotalByCategoryFiltered(
      filteredExpenses,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
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
                    const Expanded(
                      child: Text(
                        'Statistik Pengeluaran',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    _buildHeaderIcon(
                      icon: Icons.picture_as_pdf_rounded,
                      tooltip: 'Export PDF',
                      onPressed: () => _generatePdfReport(filteredExpenses),
                    ),
                    const SizedBox(width: 8),
                    // _buildHeaderIcon(
                    //   icon: Icons.download_rounded,
                    //   tooltip: 'Export CSV',
                    //   onPressed: _showExportDialog,
                    // ),
                    const SizedBox(width: 8),
                    _buildHeaderIcon(
                      icon: Icons.share_rounded,
                      tooltip: 'Bagikan CSV',
                      onPressed: () async {
                        await ExpenseService.shareCSV();
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('File CSV siap dibagikan!'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

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
                      const SizedBox(height: 24),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(
                                0xFF667eea,
                              ).withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.filter_list_rounded,
                                color: Color(0xFF667eea),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedRange,
                                    isExpanded: true,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xFF667eea),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'harian',
                                        child: Text('Harian'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'mingguan',
                                        child: Text('Mingguan'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'bulanan',
                                        child: Text('Bulanan'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'custom',
                                        child: Text('Custom Range'),
                                      ),
                                    ],
                                    onChanged: (value) async {
                                      if (value == 'custom') {
                                        final picked =
                                            await showDateRangePicker(
                                              context: context,
                                              firstDate: DateTime(2023),
                                              lastDate: DateTime.now(),
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(
                                                    context,
                                                  ).copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                          primary: Color(
                                                            0xFF667eea,
                                                          ),
                                                        ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );
                                        if (picked != null)
                                          setState(() => _customRange = picked);
                                      }
                                      setState(() => _selectedRange = value!);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (_selectedRange == 'custom' && _customRange != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF667eea,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  color: Color(0xFF667eea),
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${DateFormat('dd MMM').format(_customRange!.start)} - ${DateFormat('dd MMM yyyy').format(_customRange!.end)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF667eea),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      const SizedBox(height: 24),

                      _buildTotalCard(totalAmount, filteredExpenses),

                      const SizedBox(height: 24),

                      _buildCategoryList(totalsByCategory, totalAmount),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderIcon({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: Colors.white,
        tooltip: tooltip,
      ),
    );
  }

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

    return all
        .where((e) => e.date.isAfter(start) && e.date.isBefore(end))
        .toList();
  }

  // void _showExportDialog() {
  //   final csvContent = ExpenseService.exportToCSV();
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       title: const Text('Export ke CSV'),
  //       content: SizedBox(
  //         width: double.maxFinite,
  //         height: 300,
  //         child: SingleChildScrollView(
  //           child: SelectableText(csvContent, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
  //         ),
  //       ),
  //       actions: [
  //         TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
  //       ],
  //     ),
  //   );
  // }

  Future<void> _generatePdfReport(List expenses) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build:
            (context) => [
              pw.Center(
                child: pw.Text(
                  'Laporan Pengeluaran ($_selectedRange)',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ['Tanggal', 'Judul', 'Kategori', 'Jumlah'],
                data:
                    expenses
                        .map(
                          (e) => [
                            DateFormat('dd/MM/yyyy').format(e.date),
                            e.title,
                            e.categoryName,
                            CurrencyUtils.formatCurrency(e.amount),
                          ],
                        )
                        .toList(),
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

  Widget _buildTotalCard(double totalAmount, List filteredExpenses) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Pengeluaran',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      CurrencyUtils.formatCurrency(totalAmount),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.receipt_long_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Jumlah Item: ${filteredExpenses.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(
    Map<String, double> totalsByCategory,
    double totalAmount,
  ) {
    if (totalsByCategory.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'Tidak ada data untuk rentang waktu ini',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: totalsByCategory.length,
        itemBuilder: (context, index) {
          final categoryId = totalsByCategory.keys.elementAt(index);
          final amount = totalsByCategory[categoryId]!;
          final categoryName =
              ExpenseService.categories
                  .firstWhere(
                    (cat) => cat.id == categoryId,
                    orElse: () => Category(id: '', name: 'Unknown'),
                  )
                  .name;
          final color = _getCategoryColor(categoryName);
          final icon = _getCategoryIcon(categoryName);
          final percentage = (amount / totalAmount * 100).toStringAsFixed(1);

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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, color: color, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categoryName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$percentage% dari total',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        CurrencyUtils.formatCurrency(amount),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: amount / totalAmount,
                      minHeight: 8,
                      backgroundColor: color.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
