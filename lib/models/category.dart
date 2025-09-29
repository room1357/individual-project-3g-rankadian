class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  // Method untuk Map (untuk export jika perlu)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Factory dari Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
    );
  }

  @override
  String toString() => name; // Untuk tampilan sederhana
}