import 'package:flutter/material.dart';


class RecentShippingScreen extends StatelessWidget {
  const RecentShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shipments = [
      {
        "id": "A425HYJ8",
        "status": "On the way",
        "color": Colors.blue.shade400,
        "date": "Expected: Oct 30, 2025"
      },
      {
        "id": "A153KOJ2",
        "status": "Completed",
        "color": Colors.green.shade600,
        "date": "Delivered: Oct 27, 2025"
      },
      {
        "id": "A736UIK9",
        "status": "Pending",
        "color": Colors.orange.shade400,
        "date": "Awaiting Pickup"
      },
    ];

    return ListView.builder(
      itemCount: shipments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = shipments[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                (item['color'] as Color).withOpacity(0.04),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (item['color'] as Color).withOpacity(0.15),
              ),
              child: Icon(
                Icons.local_shipping_rounded,
                color: item['color'] as Color,
                size: 26,
              ),
            ),
            title: Text(
              "Shipment ID: ${item['id']}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                item['date'] as String,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: item['color'] as Color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
