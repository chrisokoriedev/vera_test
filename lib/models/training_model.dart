class TrainingModel {
  final String id; // Firestore document ID
  final String userId; // The trainee
  final String courseId; // The course they enrolled in
  final String courseTitle;
  final DateTime enrollmentDate;
  final bool completed;
  final String? certificateUrl; // If there is going to be a certificate
  final DateTime? completionDate;

  TrainingModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.courseTitle,
    required this.enrollmentDate,
    required this.completed,
    this.certificateUrl,
    this.completionDate,
  });
}