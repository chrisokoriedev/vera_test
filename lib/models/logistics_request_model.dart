import 'package:cloud_firestore/cloud_firestore.dart';

class LogisticsRequest {
  final String id;
  final String userId;
  final String userName; // Added for admin view
  final String userEmail; // Added for admin view
  final String serviceType; // e.g. 'Land Transport', 'Air Freight', 'Sea Cargo'
  final String pickupLocation;
  final String destination;
  final String packageDetails;
  final String status; // 'Pending', 'In Progress', 'Completed'
  final DateTime createdAt;

  LogisticsRequest({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.serviceType,
    required this.pickupLocation,
    required this.destination,
    required this.packageDetails,
    required this.status,
    required this.createdAt,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'serviceType': serviceType,
      'pickupLocation': pickupLocation,
      'destination': destination,
      'packageDetails': packageDetails,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create from Firestore document
  factory LogisticsRequest.fromMap(String id, Map<String, dynamic> map) {
    return LogisticsRequest(
      id: id,
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userEmail: map['userEmail'] ?? '',
      serviceType: map['serviceType'] ?? '',
      pickupLocation: map['pickupLocation'] ?? '',
      destination: map['destination'] ?? '',
      packageDetails: map['packageDetails'] ?? '',
      status: map['status'] ?? 'Pending',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
