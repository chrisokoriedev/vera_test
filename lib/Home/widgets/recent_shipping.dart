import 'package:flutter/material.dart';
class RecentShippingScreen extends StatelessWidget {
  const RecentShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shipments = [
      {"id": "A425HYJ8", "status": "On the way", "color": Colors.blue.shade400},
      {"id": "A153KOJ2", "status": "Completed", "color": Colors.blue.shade700},
      {"id": "A736UIK9", "status": "Pending", "color": Colors.blue.shade200},
    ];

    return ListView.builder(
      itemCount: shipments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = shipments[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: (item['color'] as Color).withOpacity(0.2),
              child: Icon(Icons.local_shipping,
                  color: item['color'] as Color, size: 24),
            ),
            title: Text(
              item['id'] as String,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            subtitle: const Text(
              "Shipment ID",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item['status'] as String,
                style: TextStyle(
                  color: item['color'] as Color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
