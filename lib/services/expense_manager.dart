import '../models/expense.dart';
import 'package:collection/collection.dart';

class ExpenseManager {
  // Data sample yang akan digunakan untuk pengujian fungsi-fungsi
  static List<Expense> expenses = [
    Expense(
      id: '1',
      title: 'Belanja Bulanan',
      amount: 150000,
      categoryId: 'makanan',
      date: DateTime(2024, 9, 15),
      description: 'Belanja kebutuhan bulanan di supermarket',
    ),
    Expense(
      id: '2',
      title: 'Bensin Motor',
      amount: 50000,
      categoryId: 'transportasi',
      date: DateTime(2024, 9, 14),
      description: 'Isi bensin motor untuk transportasi',
    ),
    Expense(
      id: '3',
      title: 'Kopi di Cafe',
      amount: 25000,
      categoryId: 'makanan',
      date: DateTime(2024, 9, 14),
      description: 'Ngopi pagi dengan teman',
    ),
    Expense(
      id: '4',
      title: 'Tagihan Internet',
      amount: 300000,
      categoryId: 'utilitas',
      date: DateTime(2024, 9, 13),
      description: 'Tagihan internet bulanan',
    ),
    Expense(
      id: '5',
      title: 'Tiket Bioskop',
      amount: 100000,
      categoryId: 'hiburan',
      date: DateTime(2024, 9, 12),
      description: 'Nonton film weekend bersama keluarga',
    ),
    Expense(
      id: '6',
      title: 'Beli Buku',
      amount: 75000,
      categoryId: 'pendidikan',
      date: DateTime(2024, 9, 11),
      description: 'Buku pemrograman untuk belajar',
    ),
    Expense(
      id: '7',
      title: 'Makan Siang',
      amount: 35000,
      categoryId: 'makanan',
      date: DateTime(2024, 9, 11),
      description: 'Makan siang di restoran',
    ),
    Expense(
      id: '8',
      title: 'Ongkos Bus',
      amount: 10000,
      categoryId: 'transportasi',
      date: DateTime(2024, 9, 10),
      description: 'Ongkos perjalanan harian ke kampus',
    ),
  ];

  // 1. Mendapatkan total pengeluaran per kategori
  static Map<String, double> getTotalByCategory(List<Expense> expenses) {
    Map<String, double> result = {};
    for (var expense in expenses) {
      result[expense.categoryName] =
          (result[expense.categoryName] ?? 0) + expense.amount;
    }
    return result;
  }

  // 2. Mendapatkan pengeluaran tertinggi
  static Expense? getHighestExpense(List<Expense> expenses) {
    if (expenses.isEmpty) return null;
    return expenses.reduce((a, b) => a.amount > b.amount ? a : b);
  }

  // 3. Mendapatkan pengeluaran bulan tertentu
  static List<Expense> getExpensesByMonth(List<Expense> expenses, int month, int year) {
    return expenses
        .where((expense) =>
            expense.date.month == month && expense.date.year == year)
        .toList();
  }

  // 4. Mencari pengeluaran berdasarkan kata kunci
  static List<Expense> searchExpenses(List<Expense> expenses, String keyword) {
    String lowerKeyword = keyword.toLowerCase();
    return expenses.where((expense) =>
        expense.title.toLowerCase().contains(lowerKeyword) ||
        expense.description.toLowerCase().contains(lowerKeyword) ||
        expense.categoryName.toLowerCase().contains(lowerKeyword)).toList();
  }

  // 5. Mendapatkan rata-rata pengeluaran harian
  static double getAverageDaily(List<Expense> expenses) {
    if (expenses.isEmpty) return 0;
    double total = expenses.fold(0, (sum, expense) => sum + expense.amount);
    Set<String> uniqueDays = expenses
        .map((expense) =>
            '${expense.date.year}-${expense.date.month}-${expense.date.day}')
        .toSet();
    return total / uniqueDays.length;
  }

  // Filtering
  static List<Expense> getFoodExpenses(List<Expense> expenses) {
    return expenses
        .where((expense) => expense.categoryName.toLowerCase() == 'makanan')
        .toList();
  }

  static List<Expense> getExpensiveItems(List<Expense> expenses, double threshold) {
    return expenses.where((expense) => expense.amount > threshold).toList();
  }

  // Transformasi
  static List<String> getExpenseTitles(List<Expense> expenses) {
    return expenses.map((expense) => expense.title).toList();
  }

  static List<String> getExpenseSummaries(List<Expense> expenses) {
    return expenses
        .map((expense) => '${expense.title}: ${expense.formattedAmount}')
        .toList();
  }

  // Grouping dengan groupBy
  static Map<String, List<Expense>> groupByCategory(List<Expense> expenses) {
    return groupBy(expenses, (expense) => expense.categoryName);
  }

  // Sorting
  static List<Expense> sortByAmountDescending(List<Expense> expenses) {
    List<Expense> sortedList = [...expenses];
    sortedList.sort((a, b) => b.amount.compareTo(a.amount));
    return sortedList;
  }

  static List<Expense> sortByDateDescending(List<Expense> expenses) {
    List<Expense> sortedList = [...expenses];
    sortedList.sort((a, b) => b.date.compareTo(a.date));
    return sortedList;
  }
}
