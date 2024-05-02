import 'dart:convert';

import 'package:immence_task/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static Future<UserModel?> getUsers() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final userPref = pref.getString("UserData");
      return UserModel.fromJson(jsonDecode(userPref ?? ''));
    } catch (e) {
      return null;
    }
  }

  static setUsers(UserModel user) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(
      "UserData",
      jsonEncode(
        user.toJson(),
      ),
    );
  }

  static clearPref() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
