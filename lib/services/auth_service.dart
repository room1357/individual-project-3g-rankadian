import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'expense_service.dart';

class AppUser {
  final String id;
  final String email;
  final String name;
  final String password;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'password': password,
  };

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
    );
  }
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final _uuid = const Uuid();
  AppUser? _currentUser;
  List<AppUser> _users = [];

  AppUser? get currentUser => _currentUser;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString('users');
    final currentString = prefs.getString('currentUser');

    if (usersString != null) {
      final list = jsonDecode(usersString) as List;
      _users = list.map((e) => AppUser.fromJson(e)).toList();
    }
    if (currentString != null) {
      _currentUser = AppUser.fromJson(jsonDecode(currentString));
    }
  }

  Future<bool> register(String email, String name, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (_users.any((u) => u.email == email)) return false;

    final newUser = AppUser(
      id: _uuid.v4(),
      email: email,
      name: name,
      password: password,
    );

    _users.add(newUser);
    _currentUser = newUser;

    await prefs.setString(
      'users',
      jsonEncode(_users.map((e) => e.toJson()).toList()),
    );
    await prefs.setString('currentUser', jsonEncode(newUser.toJson()));
    return true;
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final user = _users.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => AppUser(id: '', email: '', name: '', password: ''),
    );

    if (user.id.isEmpty) return false;

    _currentUser = user;
    await prefs.setString('currentUser', jsonEncode(user.toJson()));
    await ExpenseService.initialize();
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = null;
    await prefs.remove('currentUser');
    await ExpenseService.initialize();
  }

  List<AppUser> getAllUsers() => _users;

  Future<void> updateCurrentUser(AppUser updatedUser) async {
    final prefs = await SharedPreferences.getInstance();

    final index = _users.indexWhere((u) => u.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser;
    }

    _currentUser = updatedUser;

    await prefs.setString(
      'users',
      jsonEncode(_users.map((e) => e.toJson()).toList()),
    );
    await prefs.setString('currentUser', jsonEncode(updatedUser.toJson()));
  }

  Future<void> updateUserList(List<AppUser> users) async {
    final prefs = await SharedPreferences.getInstance();
    _users = users;
    await prefs.setString(
      'users',
      jsonEncode(users.map((e) => e.toJson()).toList()),
    );
  }
}
