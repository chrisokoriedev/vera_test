import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vericon/auth/auth_widgets.dart';
import 'package:vericon/Providers/logistics_provider.dart';
import 'package:vericon/Providers/user_provider.dart';
import 'package:vericon/Logistics/tracking_screen.dart';

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
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Fetch requests when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LogisticsProvider>(context, listen: false);
      provider.fetchRequests();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pickupController.dispose();
    _deliveryController.dispose();
    _packageController.dispose();
    super.dispose();
  }

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
                      radius: 22,
                      backgroundColor: Colors.blue.shade50,
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
                  key: _formKey,
                  child: Column(
                    children: [
                      MyCustomTextField(
                        controller: _nameController,
                        hintText: "Full Name",
                        prefixIcon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      MyCustomTextField(
                        controller: _pickupController,
                        hintText: "Pickup Address",
                        prefixIcon: Icons.location_city,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pickup address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      MyCustomTextField(
                        controller: _deliveryController,
                        hintText: "Delivery Address",
                        prefixIcon: Icons.location_on_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter delivery address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      MyCustomTextField(
                        controller: _packageController,
                        hintText: "Package Details",
                        prefixIcon: Icons.inventory_2_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter package details';
                          }
                          return null;
                        },
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
                          initialValue: _serviceType,
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
                          onPressed: _isSubmitting ? null : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => _isSubmitting = true);
                              
                              final logisticsProvider = Provider.of<LogisticsProvider>(context, listen: false);
                              final userProvider = Provider.of<UserProvider>(context, listen: false);
                              
                              final userName = _nameController.text.trim();
                              final userEmail = userProvider.currentUser?.email ?? '';
                              
                              final result = await logisticsProvider.createRequest(
                                userName: userName,
                                userEmail: userEmail,
                                serviceType: _serviceType,
                                pickupLocation: _pickupController.text.trim(),
                                destination: _deliveryController.text.trim(),
                                packageDetails: _packageController.text.trim(),
                              );

                              setState(() => _isSubmitting = false);

                              if (result == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Request submitted successfully!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                _nameController.clear();
                                _pickupController.clear();
                                _deliveryController.clear();
                                _packageController.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
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

                // My recent request header
                Text(
                  "My Recent Requests",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // for the request cards
                Consumer<LogisticsProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final requests = provider.userRequests;

                    if (requests.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'No requests yet',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: requests.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final request = requests[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrackingScreen(requestId: request.id),
                                ),
                              );
                            },
                            child: RequestCard(
                              id: request.id.substring(0, 8).toUpperCase(),
                              status: request.status,
                              serviceType: request.serviceType,
                            ),
                          );
                        },
                      ),
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
  final String serviceType;

  const RequestCard({
    super.key,
    required this.id,
    required this.status,
    required this.serviceType,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(status);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.2),
          child: Icon(Icons.local_shipping, color: statusColor),
        ),
        title: Text(
          "Request ID: $id",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status: $status",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              serviceType,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
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

