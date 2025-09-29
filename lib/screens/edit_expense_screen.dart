import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/expense_service.dart';
import '../utils/date_utils.dart';
import 'advanced_expense_list_screen.dart';

class EditExpenseScreen extends StatefulWidget {
  final Expense expense;
  const EditExpenseScreen({super.key, required this.expense});

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late String _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.expense.title);
    _amountController = TextEditingController(
      text: widget.expense.amount.toString(),
    );
    _descriptionController = TextEditingController(
      text: widget.expense.description,
    );
    _selectedDate = widget.expense.date;
    _selectedCategoryId = widget.expense.categoryId;
  }

  @override
  Widget build(BuildContext context) {
    final categories = ExpenseService.categories;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Pengeluaran')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Jumlah'),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategoryId,
              decoration: const InputDecoration(labelText: 'Kategori'),
              items:
                  categories
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat.id,
                          child: Text(cat.name),
                        ),
                      )
                      .toList(),
              onChanged:
                  (value) => setState(
                    () => _selectedCategoryId = value ?? _selectedCategoryId,
                  ),
            ),
            ListTile(
              title: Text(MyDateUtils.formatDate(_selectedDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2024, 12),
                );
                if (picked != null) setState(() => _selectedDate = picked);
              },
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateExpense,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateExpense() {
    if (_titleController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      final updatedExpense = Expense(
        id: widget.expense.id,
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        categoryId: _selectedCategoryId,
        date: _selectedDate,
        description: _descriptionController.text,
      );
      ExpenseService.updateExpense(widget.expense.id, updatedExpense);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdvancedExpenseListScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Isi judul dan jumlah!')));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
