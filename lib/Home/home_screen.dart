import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VeriConnect'),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          CircleAvatar(backgroundImage: AssetImage('assets/profile.jpg')),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Welcome, Vera 👋",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("Services", style: TextStyle(fontSize: 20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:  [
                    Column(
                      children: [
                        _FeatureCard(icon: Icons.school),
                        Text("Training ", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        _FeatureCard(icon: Icons.local_shipping),
                        Text("Logistics", style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Column(
                      children: [
                        _FeatureCard(icon: Icons.business_center),
                        Text("Services",style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        _FeatureCard(icon: Icons.announcement),
                        Text("Announcments",style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              // Banners, Latest Updates etc.
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  // final String title;
  final VoidCallback? onTap;

  const _FeatureCard({
    required this.icon,
    // required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 4,
        margin: EdgeInsets.all(15),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.blue.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blueAccent),

            ],
          ),
        ),
      ),
    );
  }
}
