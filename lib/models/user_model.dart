class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role; // e.g. 'trainee', 'client', 'admin'
  final String? phone;
  final String? profileImage;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.profileImage,
    required this.createdAt,
  });
}