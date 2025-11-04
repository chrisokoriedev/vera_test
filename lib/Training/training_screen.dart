import 'package:flutter/material.dart';
import 'course_details_screen.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final List<Map<String, String>> _courses = [
    {
      'title': 'Freight Forwarding Basics',
      'description': 'Learn the fundamentals of freight management and documentation.',
      'duration': '3 Weeks',
      'level': 'Beginner',
      'status': 'Enroll',
      'price': '₦45,000',
      'image': 'assets/images/Image 1.jpg',
    },
    {
      'title': 'Digital Supply Chain Management',
      'description': 'Understand modern trends and digital tools in logistics systems.',
      'duration': '4 Weeks',
      'level': 'Intermediate',
      'status': 'Continue',
      'price': '₦70,000',
      'image': 'assets/images/Image 2.jpg',
    },
    {
      'title': 'Global Trade Compliance',
      'description': 'Master import/export documentation and compliance strategies.',
      'duration': '2 Weeks',
      'level': 'Advanced',
      'status': 'Enroll',
      'price': '₦150,000',
      'image': 'assets/images/Image 3.jpg',
    },
  ];

  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFe6f0ff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Training Programs',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(Icons.school_rounded, color: Colors.blue, size: 24),
                    ),
                  ],
                ),
              ),

              //  Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for a course...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade100),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                ),
              ),

              // filters
              SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    FilterChipWidget(
                      label: 'All',
                      selected: selectedFilter == 'All',
                      onSelected: () => setState(() => selectedFilter = 'All'),
                    ),
                    FilterChipWidget(
                      label: 'Ongoing',
                      selected: selectedFilter == 'Ongoing',
                      onSelected: () => setState(() => selectedFilter = 'Ongoing'),
                    ),
                    FilterChipWidget(
                      label: 'Completed',
                      selected: selectedFilter == 'Completed',
                      onSelected: () => setState(() => selectedFilter = 'Completed'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // COURSE LIST
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}

//  For the filter chip
class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
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


class CourseCard extends StatelessWidget {
  final Map<String, String> course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(course['image'] ?? 'assets/images/default.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏷 Title
            Text(
              course['title']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),

            // Description
            Text(
              course['description']!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 12),

            // Info Row  for (Duration + Price + Button)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Duration & Level
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${course['duration']} • ${course['level']}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course['price'] ?? "₦—",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                //   Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CourseDetailScreen(course: course),
                      ),
                    );
                  },
                  icon: Icon(
                    course['status'] == "Continue"
                        ? Icons.play_arrow
                        : Icons.school,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: Text(
                    course['status'] == "Continue" ? "Continue" : "Enroll",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: course['status'] == "Continue"
                        ? Colors.green.shade700
                        : Colors.blue.shade700,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
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
