import '../models/expense.dart';

class LoopingExamples {
  // Data sample yang akan digunakan untuk pengujian fungsi-fungsi
  static List<Expense> expenses = [
    Expense(
      id: '1',
      title: 'Belanja Bulanan',
      amount: 150000,
      category: 'Makanan',
      date: DateTime(2024, 9, 15),
      description: 'Belanja kebutuhan bulanan di supermarket',
    ),
    Expense(
      id: '2',
      title: 'Bensin Motor',
      amount: 50000,
      category: 'Transportasi',
      date: DateTime(2024, 9, 14),
      description: 'Isi bensin motor untuk transportasi',
    ),
    Expense(
      id: '3',
      title: 'Kopi di Cafe',
      amount: 25000,
      category: 'Makanan',
      date: DateTime(2024, 9, 14),
      description: 'Ngopi pagi dengan teman',
    ),
    Expense(
      id: '4',
      title: 'Tagihan Internet',
      amount: 300000,
      category: 'Utilitas',
      date: DateTime(2024, 9, 13),
      description: 'Tagihan internet bulanan',
    ),
    Expense(
      id: '5',
      title: 'Tiket Bioskop',
      amount: 100000,
      category: 'Hiburan',
      date: DateTime(2024, 9, 12),
      description: 'Nonton film weekend bersama keluarga',
    ),
    Expense(
      id: '6',
      title: 'Beli Buku',
      amount: 75000,
      category: 'Pendidikan',
      date: DateTime(2024, 9, 11),
      description: 'Buku pemrograman untuk belajar',
    ),
    Expense(
      id: '7',
      title: 'Makan Siang',
      amount: 35000,
      category: 'Makanan',
      date: DateTime(2024, 9, 11),
      description: 'Makan siang di restoran',
    ),
    Expense(
      id: '8',
      title: 'Ongkos Bus',
      amount: 10000,
      category: 'Transportasi',
      date: DateTime(2024, 9, 10),
      description: 'Ongkos perjalanan harian ke kampus',
    ),
  ];

  // 1. Menghitung total dengan berbagai cara

  // Cara 1: For loop tradisional
  static double calculateTotalTraditional(List<Expense> expenses) {
    double total = 0;
    for (int i = 0; i < expenses.length; i++) {
      total += expenses[i].amount;
    }
    return total;
  }

  // Cara 2: For-in loop
  static double calculateTotalForIn(List<Expense> expenses) {
    double total = 0;
    for (Expense expense in expenses) {
      total += expense.amount;
    }
    return total;
  }

  // Cara 3: forEach method
  static double calculateTotalForEach(List<Expense> expenses) {
    double total = 0;
    expenses.forEach((expense) {
      total += expense.amount;
    });
    return total;
  }

  // Cara 4: fold method (paling efisien untuk akumulasi)
  static double calculateTotalFold(List<Expense> expenses) {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  // Cara 5: reduce method (dengan pengecekan kosong)
  static double calculateTotalReduce(List<Expense> expenses) {
    if (expenses.isEmpty) return 0; // Hindari error pada list kosong
    return expenses.map((e) => e.amount).reduce((a, b) => a + b);
  }

  // 2. Mencari item dengan berbagai cara

  // Cara 1: For loop dengan break
  static Expense? findExpenseTraditional(List<Expense> expenses, String id) {
    for (int i = 0; i < expenses.length; i++) {
      if (expenses[i].id == id) {
        return expenses[i];
      }
    }
    return null;
  }

  // Cara 2: firstWhere method dengan try-catch (aman untuk null)
  static Expense? findExpenseWhere(List<Expense> expenses, String id) {
    try {
      return expenses.firstWhere((expense) => expense.id == id);
    } catch (e) {
      // firstWhere akan throw StateError jika tidak ditemukan
      return null;
    }
  }

  // Cara 3: firstWhere dengan try-catch (alternatif untuk orElse, lebih aman)
  static Expense? findExpenseWhereOrElse(List<Expense> expenses, String id) {
    try {
      return expenses.firstWhere((expense) => expense.id == id);
    } catch (e) {
      return null; // Kembalikan null jika tidak ditemukan, tanpa type cast
    }
  }

  // 3. Filtering dengan berbagai cara

  // Cara 1: Loop manual dengan List.add()
  static List<Expense> filterByCategoryManual(
    List<Expense> expenses,
    String category,
  ) {
    List<Expense> result = [];
    for (Expense expense in expenses) {
      if (expense.category.toLowerCase() == category.toLowerCase()) {
        result.add(expense);
      }
    }
    return result;
  }

  // Cara 2: where method (lebih efisien dan idiomatik)
  static List<Expense> filterByCategoryWhere(
    List<Expense> expenses,
    String category,
  ) {
    return expenses
        .where(
          (expense) => expense.category.toLowerCase() == category.toLowerCase(),
        )
        .toList();
  }
}
