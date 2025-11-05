class CourseModel {
  final String id;
  final String title;
  final String description;
  final String duration;
  final String level;
  final String instructor;
  final String? imageUrl;
  final double price;
  final DateTime createdAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.level,
    required this.instructor,
    this.imageUrl,
    required this.price,
    required this.createdAt,
  });
}