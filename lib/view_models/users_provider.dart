import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:immence_task/models/user_model.dart';
import 'package:immence_task/utilities/utility_methods.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> userDataList = [];
  UserModel? user;

  Future<void> storeUserData({
    required UserModel user,
    required Function() onSuccess,
  }) async {
    try {
      CollectionReference usersListRef =
          FirebaseFirestore.instance.collection('users');
      await usersListRef.add(user.toJson());
      await Utility.setUsers(user);
      onSuccess();

      log('User data stored successfully!');
    } catch (e) {
      log('Error storing user data: $e');
    }
  }

  Future<void> getAllUserData() async {
    List<UserModel> tempUsersList = [];
    try {
      CollectionReference userDataRef =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await userDataRef.get();

      for (var doc in querySnapshot.docs) {
        final userData = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        if (user?.email != null && user!.email == userData.email) {
          user = userData;
        }
        tempUsersList.add(userData);
      }
      userDataList = tempUsersList;
      notifyListeners();
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  Future<void> getCurrentUserData() async {
    final userData = await Utility.getUsers();
    if (userData != null) {
      user = userData;
    }
    notifyListeners();
  }
}
