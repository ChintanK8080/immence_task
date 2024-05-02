import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:immence_task/models/user_model.dart';
import 'package:immence_task/utilities/utility_methods.dart';
import 'package:immence_task/view/home_page.dart';
import 'package:immence_task/view/login_page.dart';

class AuthProvider with ChangeNotifier {
  Future<UserCredential?> createNewUser({
    required UserModel user,
    required String password,
    required BuildContext context,
    required Function(UserModel user) onSuccess,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      if (credential.user != null) {
        if (user.name.trim().isNotEmpty) {
          credential.user!.updateDisplayName(user.name.trim());
        }
      }
      onSuccess(user);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        FlutterToastr.show('The password provided is too weak.', context);
      } else if (e.code == 'email-already-in-use') {
        FlutterToastr.show(
            'The account already exists for that email.', context);
      }
    } catch (e) {
      FlutterToastr.show(e.toString(), context);
    }
    return null;
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        await Utility.setUsers(UserModel(
            name: credential.user?.displayName ?? '',
            phone: credential.user?.phoneNumber ?? '',
            email: credential.user?.email ?? ''));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        FlutterToastr.show(e.message ?? '', context, duration: 3);
      } else if (e.code == 'wrong-password') {
        FlutterToastr.show(e.message ?? '', context, duration: 3);
      } else if (e.code == "invalid-credential") {
        FlutterToastr.show(e.message ?? '', context, duration: 3);
      } else if (e.code == "invalid-email") {
        FlutterToastr.show(e.message ?? '', context, duration: 3);
      } else if (e.code == "user-disabled") {
        FlutterToastr.show(e.message ?? '', context, duration: 3);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await Utility.clearPref();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false);
  }

  void validator(BuildContext context,
      {required String email,
      required String password,
      String? name,
      String? phoneNumber,
      required Function() onSuccess}) {
    if (name != null && name.isEmpty) {
      FlutterToastr.show(
        "Please enter valid name",
        context,
      );
    } else if (email.isEmpty || !Utility.isValidEmail(email)) {
      FlutterToastr.show(
        "Please enter valid email",
        context,
      );
    } else if (phoneNumber != null &&
        (phoneNumber.length < 10 || phoneNumber.length < 10)) {
      FlutterToastr.show(
        "Phone Number must be between 10 to 12 digits",
        context,
      );
    } else if (password.length < 8) {
      FlutterToastr.show(
        "Password must be contain at least 8 characters",
        context,
      );
    } else {
      onSuccess();
    }
  }
}
