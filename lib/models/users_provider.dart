import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  List<Map<String, dynamic>> userDataList = [];
  String? name;
  String? phone;
  String? email;

  Future<void> storeUserData({
    required String name,
    required String email,
    required String phone,
    required Function() onSuccess,
  }) async {
    try {
      CollectionReference usersListRef =
          FirebaseFirestore.instance.collection('users');
      final userData = {
        'name': name,
        'email': email,
        'phone': phone,
      };
      await usersListRef.add(userData);
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("UserData", jsonEncode(userData));
      onSuccess();

      log('User data stored successfully!');
    } catch (e) {
      log('Error storing user data: $e');
    }
  }

  Future<void> getAllUserData() async {
    List<Map<String, dynamic>> tempUsersList = [];
    try {
      CollectionReference userDataRef =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await userDataRef.get();

      for (var doc in querySnapshot.docs) {
        Object? userData = doc.data();
        tempUsersList.add(userData as Map<String, dynamic>);
      }
      userDataList = tempUsersList;
      notifyListeners();
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  Future<void> getCurrentUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userData = pref.getString("UserData");
    if (userData != null) {
      final userDataMap = jsonDecode(userData);
      name = userDataMap["name"];
      phone = userDataMap["phone"];
      email = userDataMap["email"];
    }
    notifyListeners();
  }
}
