
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProviderService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  User? get user => _user;

  // To check if user is logged in
  bool get isAuthenticated => _user != null;

  AuthProviderService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Sign Up Method
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Login Method
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
