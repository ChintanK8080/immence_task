import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immence_task/view/home_page.dart';
import 'package:immence_task/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  Future<UserCredential?> createNewUser({
    required String email,
    required String password,
    required String phone,
    required String name,
    required BuildContext context,
    required Function(String email, String phone, String name) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        if (name.trim().isNotEmpty) {
          credential.user!.updateDisplayName(name.trim());
        }
      }
      onSuccess(email, phone, name);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
      }
    } catch (e) {
      onError(e.toString());
    }
    return null;
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context,
      required Function(String error) onError}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString(
          "UserData",
          jsonEncode(
            {
              "name": credential.user?.displayName,
              "email": credential.user?.email,
              "phone": credential.user?.phoneNumber
            },
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError(e.message ?? '');
      } else if (e.code == 'wrong-password') {
        onError(e.message ?? '');
      } else if (e.code == "invalid-credential") {
        onError(e.message ?? '');
      } else if (e.code == "invalid-email") {
        onError(e.message ?? '');
      } else if (e.code == "user-disabled") {
        onError(e.message ?? '');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false);
  }
}
