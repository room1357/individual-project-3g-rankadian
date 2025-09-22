// import 'package:flutter/material.dart';
// import 'screens/login_screen.dart';
// import 'screens/register_screen.dart';
// import 'screens/home_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/looping_examples.dart'; // Import LoopingExamples untuk pengujian
import 'models/expense.dart'; // Import Expense untuk pengujian

void main() {
  print('--- Pengujian Looping Examples ---');
  List<Expense> sampleExpenses = LoopingExamples.expenses;

  // 1. Menghitung total
  print('\n--- Menghitung Total ---');
  print('Total (Traditional): ${LoopingExamples.calculateTotalTraditional(sampleExpenses)}');
  print('Total (For-in): ${LoopingExamples.calculateTotalForIn(sampleExpenses)}');
  print('Total (ForEach): ${LoopingExamples.calculateTotalForEach(sampleExpenses)}');
  print('Total (Fold): ${LoopingExamples.calculateTotalFold(sampleExpenses)}');
  print('Total (Reduce): ${LoopingExamples.calculateTotalReduce(sampleExpenses)}');

  // 2. Mencari item
  print('\n--- Mencari Item ---');
  String searchId = '3';
  print('Cari ID $searchId (Traditional): ${LoopingExamples.findExpenseTraditional(sampleExpenses, searchId)?.title}');
  print('Cari ID $searchId (firstWhere): ${LoopingExamples.findExpenseWhere(sampleExpenses, searchId)?.title}');
  print('Cari ID $searchId (firstWhereOrElse): ${LoopingExamples.findExpenseWhereOrElse(sampleExpenses, searchId)?.title}');
  
  String nonExistentId = '99';
  print('Cari ID $nonExistentId (firstWhereOrElse): ${LoopingExamples.findExpenseWhereOrElse(sampleExpenses, nonExistentId)?.title}');

  // 3. Filtering
  print('\n--- Filtering ---');
  String filterCategory = 'Makanan';
  print('Filter Kategori "$filterCategory" (Manual): ${LoopingExamples.filterByCategoryManual(sampleExpenses, filterCategory).map((e) => e.title).toList()}');
  print('Filter Kategori "$filterCategory" (Where): ${LoopingExamples.filterByCategoryWhere(sampleExpenses, filterCategory).map((e) => e.title).toList()}');

  // Jalankan aplikasi setelah pengujian
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Pengeluaran',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(), // Halaman pertama
    );
  }
}
