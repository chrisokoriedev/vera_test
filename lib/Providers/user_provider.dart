import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAdmin => _currentUser?.role == 'admin';
  bool get isUser => _currentUser?.role == 'user';

  UserProvider() {
    // Listen to auth state changes and clear user data on logout
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        clearUser();
      } else {
        // Fetch user data when user logs in
        fetchUserData();
      }
    });
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    final user = _auth.currentUser;
    if (user == null) {
      _currentUser = null;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      
      if (doc.exists) {
        final data = doc.data()!;
        _currentUser = UserModel(
          uid: data['uid'] ?? user.uid,
          name: data['name'] ?? '',
          email: data['email'] ?? user.email ?? '',
          role: data['role'] ?? 'user',
          phone: data['phone'],
          profileImage: data['profileImage'],
          createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      } else {
        // If document doesn't exist, create it with default role
        await createUserDocument(
          uid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
        await fetchUserData(); // Fetch again after creating
      }
    } catch (e) {
      log('Error fetching user data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create user document in Firestore
  Future<void> createUserDocument({
    required String uid,
    required String name,
    required String email,
    String? phone,
    String role = 'user', // Default role
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'role': role,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });
      
      // Refresh user data
      await fetchUserData();
    } catch (e) {
      print('Error creating user document: $e');
      rethrow;
    }
  }

  // Clear user data on logout
  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }

  // Update user role (admin only - should be called from admin screen)
  Future<void> updateUserRole(String userId, String newRole) async {
    if (!isAdmin) {
      throw Exception('Only admins can update user roles');
    }

    try {
      await _firestore.collection('users').doc(userId).update({
        'role': newRole,
      });
    } catch (e) {
      print('Error updating user role: $e');
      rethrow;
    }
  }
}

