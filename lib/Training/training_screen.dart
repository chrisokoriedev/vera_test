import 'package:flutter/material.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final List<Map<String, String>> _courses = [
    {
      'title': 'Freight Forwarding Basics',
      'description':
          'Learn the fundamentals of freight management and documentation.',
      'duration': '3 Weeks',
      'level': 'Beginner',
      'status': 'Enroll',
    },
    {
      'title': 'Digital Supply Chain Management',
      'description':
          'Understand modern trends and digital tools in logistics systems.',
      'duration': '4 Weeks',
      'level': 'Intermediate',
      'status': 'Continue',
    },
    {
      'title': 'Global Trade Compliance',
      'description':
          'Master import/export documentation and compliance strategies.',
      'duration': '2 Weeks',
      'level': 'Advanced',
      'status': 'Enroll',
    },
  ];

  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFe6f0ff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Training Programs',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(Icons.school, color: Colors.blue),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                // 🔍 Search for the courses Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for a course...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // The filter widgets
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Filter(
                        label: 'All',
                        selected: selectedFilter == 'All',
                        onSelected: () =>
                            setState(() => selectedFilter = 'All'),
                      ),
                      Filter(
                        label: 'Ongoing',
                        selected: selectedFilter == 'Ongoing',
                        onSelected: () =>
                            setState(() => selectedFilter = 'Ongoing'),
                      ),
                      Filter(
                        label: 'Completed',
                        selected: selectedFilter == 'Completed',
                        onSelected: () =>
                            setState(() => selectedFilter = 'Completed'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Course List
                Expanded(
                  child: ListView.builder(
                    itemCount: _courses.length,
                    itemBuilder: (context, index) {
                      final course = _courses[index];
                      return CourseCard(course: course);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Filter bar
class Filter extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const Filter({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
        selectedColor: Colors.blue.shade700,
        backgroundColor: Colors.grey.shade200,
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

//  Course Card
class CourseCard extends StatelessWidget {
  final Map<String, String> course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding:  const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course['title']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              course['description']!,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${course['duration']} | ${course['level']}",
                  style: const TextStyle(fontSize: 13, color: Colors.black),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${course['status']} course tapped'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow, size: 18, color: Colors.white,),
                  label : Text(
                    course['status']!,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
