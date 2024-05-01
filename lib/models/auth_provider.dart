import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  User? user;
  StreamSubscription<User?>? userAuthSub;

  AuthProvider() {
    userAuthSub = FirebaseAuth.instance.authStateChanges().listen((newUser) {
      print('AuthProvider - FirebaseAuth - authStateChanges - $newUser');
      user = newUser;
      notifyListeners();
    }, onError: (e) {
      print('AuthProvider - FirebaseAuth - authStateChanges - $e');
    });
  }

  @override
  void dispose() {
    if (userAuthSub != null) {
      userAuthSub?.cancel();
      userAuthSub = null;
    }
    super.dispose();
  }

  bool get isAnonymous {
    assert(user != null);
    bool isAnonymousUser = true;
    for (UserInfo info in user!.providerData) {
      if (info.providerId == "facebook.com" ||
          info.providerId == "google.com" ||
          info.providerId == "password") {
        isAnonymousUser = false;
        break;
      }
    }
    return isAnonymousUser;
  }

  bool get isAuthenticated {
    return user != null;
  }

  Future<UserCredential?> signInAnonymously() async {
    return await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserCredential?> login(String email, String password) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(credential.credential?.providerId.toString() ?? "no id");
      log(credential.additionalUserInfo.toString());
      return credential;
    } catch (e) {
      // Handle login errors
      print(e.toString());
      return null;
    }
  }
}
