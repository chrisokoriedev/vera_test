import 'package:flutter/material.dart';
import 'package:vericon/Training/widgets/enrollment_textfeild.dart';

class EnrollmentFormScreen extends StatefulWidget {
  final Map<String, String> course;

  const EnrollmentFormScreen({super.key, required this.course});

  @override
  State<EnrollmentFormScreen> createState() => _EnrollmentFormScreenState();
}

class _EnrollmentFormScreenState extends State<EnrollmentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Mock user data (I will replace with Firebase user data later)
  final TextEditingController _nameController = TextEditingController(
    text: "Vera Ndulue",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "vera.ndulue@example.com",
  );
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();

  bool _isSubmitting = false;

  void _submitEnrollment() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isSubmitting = false);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Enrollment Successful 🎉',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              'You are now enrolled in "${widget.course['title']}".',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Enroll in Course"),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, const Color(0xFFe6f0ff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // This is for the Course Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade100,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        course['image']!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${course['duration']} • ${course['level']}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // The Enrollment Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Confirm Your Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // FullName Field
                    CourseEnrollmentForm(
                      controller: _nameController,
                      prefixIcon: Icons.person_outline,

                      validator: (v) =>
                          v!.isEmpty ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    CourseEnrollmentForm(
                      controller: _emailController,
                      readOnly: true,
                      prefixIcon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 16),

                    // Phone Field
                    CourseEnrollmentForm(
                      controller: _phoneController,
                      isPhone: true,
                      hintText: "Phone Number",
                      prefixIcon: Icons.call_outlined,
                      validator: (v) =>
                          v!.isEmpty ? 'Please enter your phone number' : null,
                    ),

                    const SizedBox(height: 16),

                    // Date selection field
                    CourseEnrollmentForm(
                      controller: _dateController,
                      prefixIcon: Icons.calendar_month_outlined,
                      hintText: "Preferred date to start",
                      validator: (v) =>
                          v!.isEmpty ? 'Please enter a date' : null,
                    ),

                    SizedBox(height: 16),
                    // Additional Note
                    CourseEnrollmentForm(
                      controller: _noteController,
                      prefixIcon: Icons.note_alt_outlined,
                      maxLines: 3,
                      hintText: "Additional note (Optional)",
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitEnrollment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: _isSubmitting
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Submit Enrollment",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
