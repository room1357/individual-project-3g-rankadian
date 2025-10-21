import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';
import '../models/category.dart';
import 'auth_service.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';


class ExpenseService {
  static List<Expense> _expenses = [];
  static final List<Category> _categories = [
    Category(id: '1', name: 'Makanan'),
    Category(id: '2', name: 'Transportasi'),
    Category(id: '3', name: 'Utilitas'),
    Category(id: '4', name: 'Hiburan'),
    Category(id: '5', name: 'Pendidikan'),
  ];

  static List<Expense> get expenses => List.from(_expenses);
  static List<Category> get categories => List.from(_categories);

  /// Inisialisasi data pengeluaran sesuai user yang login
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final user = AuthService().currentUser;

    if (user == null) {
      _expenses = [];
      return;
    }

    final key = 'expenses_${user.id}';
    final storedData = prefs.getString(key);

    if (storedData != null) {
      final decoded = jsonDecode(storedData) as List;
      _expenses = decoded.map((e) => Expense.fromJson(e)).toList();
    } else {
      _expenses = [];
    }
  }

  /// Simpan data sesuai user
  static Future<void> _saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final user = AuthService().currentUser;
    if (user == null) return;

    final key = 'expenses_${user.id}';
    final encoded = jsonEncode(_expenses.map((e) => e.toJson()).toList());
    await prefs.setString(key, encoded);
  }

  static Future<void> addExpense(Expense expense) async {
    _expenses.add(expense);
    await _saveExpenses();
  }

  static Future<void> updateExpense(String id, Expense updatedExpense) async {
    final index = _expenses.indexWhere((e) => e.id == id);
    if (index != -1) {
      _expenses[index] = updatedExpense;
      await _saveExpenses();
    }
  }

  static Future<void> deleteExpense(String id) async {
    _expenses.removeWhere((e) => e.id == id);
    await _saveExpenses();
  }

  static List<Expense> getExpensesByCategory(String categoryId) {
    return _expenses.where((e) => e.categoryId == categoryId).toList();
  }

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

  static int getExpenseCount() => _expenses.length;

  static String exportToCSV() {
    String csv = 'ID,Judul,Jumlah,Kategori,Tanggal,Deskripsi\n';
    for (var expense in _expenses) {
      csv +=
          '${expense.id},"${expense.title}",${expense.amount},${expense.categoryName},"${expense.formattedDate}","${expense.description}"\n';
    }
    
    return csv;
  }

    static Future<void> shareCSV() async {
    try {
      final csvData = exportToCSV();

      // Simpan file CSV ke direktori sementara
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/pengeluaran.csv';
      final file = File(path);
      await file.writeAsString(csvData);

      // Share file-nya
      await Share.shareXFiles(
        [XFile(path)],
        text: 'Berikut data pengeluaran saya 💸',
      );
    } catch (e) {
      debugPrint('Gagal membagikan CSV: $e');
      rethrow;
    }
  }


  static Map<String, double> getTotalByCategoryFiltered(List expenses) {
    final Map<String, double> totals = {};
    for (var e in expenses) {
      totals[e.categoryId] = (totals[e.categoryId] ?? 0) + e.amount;
    }
    return totals;
  }

  static List getAllExpenses() => _expenses;

  // Kategori
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
  }
}
