import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/expense_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _nameController = TextEditingController();

  void _showAddDialog() {
    _nameController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Kategori'),
        content: TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nama Kategori')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                final newCategory = Category(id: DateTime.now().millisecondsSinceEpoch.toString(), name: _nameController.text);
                ExpenseService.addCategory(newCategory);
                setState(() {});
                Navigator.pop(context);
              }
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(Category category) {
    _nameController.text = category.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Kategori'),
        content: TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nama Kategori')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                final updated = Category(id: category.id, name: _nameController.text);
                ExpenseService.updateCategory(category.id, updated);
                setState(() {});
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ExpenseService.categories;

    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Kategori'), actions: [IconButton(icon: const Icon(Icons.add), onPressed: _showAddDialog)]),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.edit), onPressed: () => _showEditDialog(category)),
                IconButton(icon: const Icon(Icons.delete), onPressed: () {
                  ExpenseService.deleteCategory(category.id);
                  setState(() {});
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}