import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login method
  Future<User?> login(String email, String password) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      // Handle login errors
      print(e.toString());
      return null;
    }
  }

  // Signup method
  Future<User?> signup(String email, String password) async {
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      // Handle signup errors
      print(e.toString());
      return null;
    }
  }

  // Logout method
  Future<void> logout() async {
    await _auth.signOut();
  }
}
