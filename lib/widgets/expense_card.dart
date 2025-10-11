import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.attach_money),
        ),
        title: Text(expense.title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text('${expense.category} | ${expense.formattedDate}'),
        trailing: Text(
          expense.formattedAmount,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[600]),
        ),
      ),
    );
  }
}
