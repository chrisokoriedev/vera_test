import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vericon/Providers/user_provider.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userName = userProvider.currentUser?.name ?? 'Admin';

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Admin Dashboard',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications screen
            },
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/Profile.jpg'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                "Welcome, $userName 👋",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                "Manage your platform",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 30),

              // Admin Features Section
              Text(
                "Admin Features",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),

              // Admin Feature Cards Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _AdminFeatureCard(
                    icon: Icons.school_rounded,
                    title: "Manage Trainings",
                    color1: Colors.blue.shade200,
                    color2: Colors.blue.shade100,
                    onTap: () {
                      // TODO: Navigate to manage trainings screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Manage Trainings - Coming soon")),
                      );
                    },
                  ),
                  _AdminFeatureCard(
                    icon: Icons.local_shipping_rounded,
                    title: "Manage Logistics",
                    color1: Colors.green.shade200,
                    color2: Colors.green.shade100,
                    onTap: () {
                      // TODO: Navigate to manage logistics screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Manage Logistics - Coming soon")),
                      );
                    },
                  ),
                  _AdminFeatureCard(
                    icon: Icons.article_rounded,
                    title: "Manage Content",
                    color1: Colors.orange.shade200,
                    color2: Colors.orange.shade100,
                    onTap: () {
                      // TODO: Navigate to manage content screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Manage Content - Coming soon")),
                      );
                    },
                  ),
                  _AdminFeatureCard(
                    icon: Icons.people_rounded,
                    title: "Manage Users",
                    color1: Colors.purple.shade200,
                    color2: Colors.purple.shade100,
                    onTap: () {
                      // TODO: Navigate to manage users screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Manage Users - Coming soon")),
                      );
                    },
                  ),
                  _AdminFeatureCard(
                    icon: Icons.notifications_active_rounded,
                    title: "Send Notifications",
                    color1: Colors.red.shade200,
                    color2: Colors.red.shade100,
                    onTap: () {
                      // TODO: Navigate to send notifications screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Send Notifications - Coming soon")),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Quick Stats Section (Optional - can be expanded later)
              Text(
                "Quick Stats",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: "Total Users",
                      value: "0",
                      icon: Icons.people,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      title: "Active Requests",
                      value: "0",
                      icon: Icons.local_shipping,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color1;
  final Color color2;
  final VoidCallback onTap;

  const _AdminFeatureCard({
    required this.icon,
    required this.title,
    required this.color1,
    required this.color2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1.withOpacity(0.15), color2.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: color1.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, size: 30, color: color1),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontSize: 14,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }
}
