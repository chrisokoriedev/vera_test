import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/logistics_request_model.dart';

class LogisticsProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<LogisticsRequest> _requests = [];
  bool _isLoading = false;

  List<LogisticsRequest> get requests => _requests;
  bool get isLoading => _isLoading;

  // Get user's own requests
  List<LogisticsRequest> get userRequests {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];
    return _requests.where((r) => r.userId == userId).toList();
  }

  // Get all requests (for admin)
  List<LogisticsRequest> get allRequests => _requests;

  // Create a new logistics request
  Future<String?> createRequest({
    required String userName,
    required String userEmail,
    required String serviceType,
    required String pickupLocation,
    required String destination,
    required String packageDetails,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return "User not logged in";

    try {
      final requestData = {
        'userId': user.uid,
        'userName': userName,
        'userEmail': userEmail,
        'serviceType': serviceType,
        'pickupLocation': pickupLocation,
        'destination': destination,
        'packageDetails': packageDetails,
        'status': 'Pending',
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore.collection('logistics_requests').add(requestData);
      await fetchRequests(); // Refresh list
      return null; // Success
    } catch (e) {
      return "Error creating request: $e";
    }
  }

  // Fetch all requests (admin) or user's requests
  Future<void> fetchRequests({bool adminView = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot snapshot;
      
      if (adminView) {
        // Admin sees all requests
        snapshot = await _firestore
            .collection('logistics_requests')
            .orderBy('createdAt', descending: true)
            .get();
      } else {
        // User sees only their requests
        final userId = _auth.currentUser?.uid;
        if (userId == null) {
          _requests = [];
          _isLoading = false;
          notifyListeners();
          return;
        }
        
        snapshot = await _firestore
            .collection('logistics_requests')
            .where('userId', isEqualTo: userId)
            .orderBy('createdAt', descending: true)
            .get();
      }

      _requests = snapshot.docs.map((doc) {
        return LogisticsRequest.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching requests: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update request status (admin only)
  Future<String?> updateRequestStatus(String requestId, String newStatus) async {
    try {
      await _firestore.collection('logistics_requests').doc(requestId).update({
        'status': newStatus,
      });
      await fetchRequests(adminView: true); // Refresh
      return null; // Success
    } catch (e) {
      return "Error updating status: $e";
    }
  }

  // Get request by ID
  LogisticsRequest? getRequestById(String id) {
    try {
      return _requests.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }
}

