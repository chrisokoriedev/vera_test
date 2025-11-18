
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  // Forgot password
  Future<String?> resetPassword(String email) async {
    if (email.isEmpty) {
      return "Please enter your email";
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null; // for when it is successful
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "No account exists with this email";
      }
      return e.message ?? "Unable to send reset link";
    } catch (_) {
      return "An unexpected error occurred";
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      // Step 1: Google Sign-In prompt
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return "Google sign-in cancelled";

      // Step 2: Getting auth tokens
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Step 3: Converting the tokens into Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 4: finally signing in to Firebase
      await _auth.signInWithCredential(credential);

      return null; // success
    } catch (e) {
      return e.toString();
    }
  }
}
