import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  List<Map<String, dynamic>> userDataList = [];

  Future<void> storeUserData(
      {required String name,
      required String email,
      required String phone}) async {
    try {
      CollectionReference usersListRef =
          FirebaseFirestore.instance.collection('users');

      await usersListRef.add({
        'name': name,
        'email': email,
        'phone': phone,
      });

      log('User data stored successfully!');
    } catch (e) {
      log('Error storing user data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllUserData() async {
    try {
      CollectionReference userDataRef =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await userDataRef.get();

      for (var doc in querySnapshot.docs) {
        Object? userData = doc.data();
        userDataList.add(userData as Map<String, dynamic>);
      }

      return userDataList;
    } catch (e) {
      print('Error getting user data: $e');
      return [];
    }
  }
}
