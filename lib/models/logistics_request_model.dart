class LogisticsRequest {
  final String id;
  final String userId;
  final String serviceType; // e.g. 'Freight Forwarding', 'Delivery', etc.
  final String pickupLocation;
  final String destination;
  final String packageDetails;
  final String status; // 'Pending', 'In Progress', 'Completed'
  final DateTime createdAt;

  LogisticsRequest({
    required this.id,
    required this.userId,
    required this.serviceType,
    required this.pickupLocation,
    required this.destination,
    required this.packageDetails,
    required this.status,
    required this.createdAt,
  });


  }
