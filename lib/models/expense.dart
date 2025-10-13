import 'package:flutter/material.dart';
import '../services/expense_service.dart';
import '../utils/currency_utils.dart';
import '../utils/date_utils.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String description;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    required this.description,
  });

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: (map['amount'] as num).toDouble(),
      categoryId: map['categoryId'],
      date: DateTime.parse(map['date']),
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'categoryId': categoryId,
      'date': date.toIso8601String(),
      'description': description,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) => Expense.fromMap(json);
  Map<String, dynamic> toJson() => toMap();

  String get categoryName {
    try {
      final category = ExpenseService.categories.firstWhere(
        (cat) => cat.id == categoryId,
      );
      return category.name;
    } catch (e) {
      return 'Unknown';
    }
  }

  String get category => categoryName;

  Color get categoryColor {
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
  }

  IconData get categoryIcon {
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
  }

  String get formattedAmount => CurrencyUtils.formatCurrency(amount);
  String get formattedDate => MyDateUtils.formatDate(date);

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, amount: $amount, categoryId: $categoryId, date: $date, description: $description)';
  }
}
