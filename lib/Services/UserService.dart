import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:tp3/Models/User.dart';

class UserService {
  final String _key = "current_user";

  Future<void> saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toMap());
    await prefs.setString(_key, userJson);
  }

  Future<User?> getCurrentUser() async {
    User user = User(id: "123", name: "Moncef", email: "moncef@test.com");
    return user;
    // final prefs = await SharedPreferences.getInstance();
    // final userJson = prefs.getString(_key);

    // if (userJson == null) return null;

    // final Map<String, dynamic> data = jsonDecode(userJson);
    // return User.fromMap(data);
  }

  Future<void> clearCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
