import 'package:flutter/material.dart';
import 'package:vericon/auth/auth_widgets.dart';

class LogisticsScreen extends StatefulWidget {
  const LogisticsScreen({super.key});

  @override
  State<LogisticsScreen> createState() => _LogisticsScreenState();
}

class _LogisticsScreenState extends State<LogisticsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  final TextEditingController _packageController = TextEditingController();

  String _serviceType = 'Land Transport';

  // Sample logistics requests
  final List<Map<String, dynamic>> _requests = [
    {'id': 'A425HYJ8', 'status': 'On the way', 'color': Colors.orange},
    {'id': 'B153KOJ2', 'status': 'Completed', 'color': Colors.blue},
    {'id': 'C981PLM9', 'status': 'Pending', 'color': Colors.blueGrey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFe6f0ff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logistic service heading
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Logistics Services',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Request a Logistics Service",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 16),

                //  Logistics form
                Form(
                  child: Column(
                    children: [
                      MyCustomTextField(
                        controller: _nameController,
                        hintText: "Full Name",
                        prefixIcon: Icons.person,
                      ),
                      SizedBox(height: 10),
                      MyCustomTextField(
                        controller: _pickupController,
                        hintText: "Pickup Address",
                        prefixIcon: Icons.location_city,
                      ),
                      SizedBox(height: 10),
                      MyCustomTextField(
                        controller: _deliveryController,
                        hintText: "Delivery Address",
                        prefixIcon: Icons.location_on_rounded,
                      ),
                      SizedBox(height: 10),
                      MyCustomTextField(
                        controller: _packageController,
                        hintText: "Package Details",
                        prefixIcon: Icons.inventory_2_rounded,
                      ),

                      const SizedBox(height: 10),

                      // Dropdown for the service type
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _serviceType,
                          items: [
                            DropdownMenuItem(
                              value: 'Land Transport',
                              child: Text(
                                'Land Transport',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Air Freight',
                              child: Text(
                                'Air Freight',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Sea Cargo',
                              child: Text(
                                'Sea Cargo',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _serviceType = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Select Service Type',
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // The submit button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Logistics request submitted!'),
                                ),
                              );
                              _nameController.clear();
                              _pickupController.clear();
                              _deliveryController.clear();
                              _packageController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Submit Request",
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                // Recent Requests
                Text(
                  "My Recent Requests",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // for the request cards
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _requests.length,
                  itemBuilder: (context, index) {
                    final request = _requests[index];
                    return RequestCard(
                      id: request['id'],
                      status: request['status'],
                      color: request['color'],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Recent request list
class RequestCard extends StatelessWidget {
  final String id;
  final String status;
  final Color color;

  const RequestCard({
    super.key,
    required this.id,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(Icons.local_shipping, color: color),
        ),
        title: Text(
          "Request ID: $id",
          // style: const TextStyle(fontWeight: FontWeight.bold),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        subtitle: Text(
          "Status: $status",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.black),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
