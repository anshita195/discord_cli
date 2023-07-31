// db/db_helper.dart

import 'dart:io';
import 'dart:convert';
import '../models/user.dart';

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException(this.message);

  @override
  String toString() => 'Exception Type: User not found\n$message';
}

class DbHelper {
  final String _databasePath = 'database.txt';

  List<User> _users = [];

  Future<void> openDatabase() async {
    try {
      final file = File(_databasePath);
      if (await file.exists()) {
        final jsonData = await file.readAsString();
        final List<dynamic> userJsonList = jsonDecode(jsonData);
        _users = userJsonList.map((json) => User.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error opening database: $e');
    }
  }

  bool isUserRegistered(String username) {
    return _users.any((user) => user.username == username);
  }

  User _findUserByUsername(String username) {
    return _users.firstWhere((user) => user.username == username, orElse: () => User(username));
  }

  void registerUser(String username) {
    if (isUserRegistered(username)) {
      print('Failure: User $username is already registered.');
    } else {
      final user = User(username);
      _users.add(user);
      _saveDataToFile();
      print('Success: User $username registered.');
    }
  }

  void loginUser(String username) {
    final user = _findUserByUsername(username);
    if (!user.isLoggedIn) {
      user.isLoggedIn = true;
      _saveDataToFile();
      print('Login success: User $username logged in.');
    } else {
      print('Warning: User $username is already logged in.');
    }
  }

  void logoutUser(String username) {
    final user = _findUserByUsername(username);
    if (user.isLoggedIn) {
      user.isLoggedIn = false;
      _saveDataToFile();
      print('Logout success: User $username logged out.');
    } else {
      print('Warning: User $username is already logged out.');
    }
  }

  void _saveDataToFile() async {
    try {
      final jsonData = _users.map((user) => user.toJson()).toList();
      final file = File(_databasePath);
      await file.writeAsString(jsonEncode(jsonData));
    } catch (e) {
      print('Error saving data: $e');
    }
  }
}
