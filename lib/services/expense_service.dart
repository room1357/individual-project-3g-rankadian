import '../models/expense.dart';
import '../models/category.dart';

class ExpenseService {
  static List<Expense> _expenses = []; // In-memory data
  static final List<Category> _categories = [
    Category(id: '1', name: 'Makanan'),
    Category(id: '2', name: 'Transportasi'),
    Category(id: '3', name: 'Utilitas'),
    Category(id: '4', name: 'Hiburan'),
    Category(id: '5', name: 'Pendidikan'),
  ];

  // Getter (return copy untuk safety)
  static List<Expense> get expenses => List.from(_expenses);
  static List<Category> get categories => List.from(_categories);

  // Inisialisasi dengan data sampel (panggil di main())
  static void initialize() {
    if (_expenses.isEmpty) {
      // Data sampel (update category menjadi categoryId)
      _expenses = [
        Expense(
          id: '1',
          title: 'Belanja Bulanan',
          amount: 150000,
          categoryId: '1',
          date: DateTime(2024, 9, 15),
          description: 'Belanja kebutuhan',
        ),
        Expense(
          id: '2',
          title: 'Bensin Motor',
          amount: 50000,
          categoryId: '2',
          date: DateTime(2024, 9, 14),
          description: 'Isi bensin',
        ),
        Expense(
          id: '3',
          title: 'Kopi di Cafe',
          amount: 25000,
          categoryId: '1',
          date: DateTime(2024, 9, 14),
          description: 'Ngopi pagi',
        ),
        // Tambah lebih banyak jika perlu
      ];
    }
  }

  // CRUD Expense
  static void addExpense(Expense expense) {
    _expenses.add(expense);
  }

  static void updateExpense(String id, Expense updatedExpense) {
    final index = _expenses.indexWhere((e) => e.id == id);
    if (index != -1) {
      _expenses[index] = updatedExpense;
    }
  }

  static void deleteExpense(String id) {
    _expenses.removeWhere((e) => e.id == id);
  }

  // Filter sederhana
  static List<Expense> getExpensesByCategory(String categoryId) {
    return _expenses.where((e) => e.categoryId == categoryId).toList();
  }

  // Statistik sederhana (menggunakan fold dan where)
  static double getTotalAmount() {
    return _expenses.fold(0, (sum, e) => sum + e.amount);
  }

  static Map<String, double> getTotalByCategory() {
    final Map<String, double> totals = {};
    for (var expense in _expenses) {
      totals[expense.categoryId] =
          (totals[expense.categoryId] ?? 0) + expense.amount;
    }
    return totals;
  }

  static int getExpenseCount() {
    return _expenses.length;
  }

  // CRUD Category (simple)
  static void addCategory(Category category) {
    _categories.add(category);
  }

  static void updateCategory(String id, Category updatedCategory) {
    final index = _categories.indexWhere((c) => c.id == id);
    if (index != -1) {
      _categories[index] = updatedCategory;
    }
  }

  static void deleteCategory(String id) {
    _categories.removeWhere((c) => c.id == id);
    // Opsional: Hapus expenses dengan category ini
    // _expenses.removeWhere((e) => e.categoryId == id);
  }

  // Export CSV sederhana (return string)
  static String exportToCSV() {
    String csv = 'ID,Judul,Jumlah,Kategori,Tanggal,Deskripsi\n';
    for (var expense in _expenses) {
      csv +=
          '${expense.id},"${expense.title}",${expense.amount},${expense.categoryName},"${expense.formattedDate}","${expense.description}"\n';
    }
    return csv;
  }
}
