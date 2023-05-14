import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_balls/model/user.dart';

class UserRepository {
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = user.toMap();
    await prefs.setString('user', json.encode(userData));
  }

  Future<User> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user')) {
      return const User();
    }
    final userData = json.decode(prefs.getString('user')!);
    return User.fromMap(userData as Map<String, dynamic>);
  }
}
