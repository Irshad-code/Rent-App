import 'package:flutter/material.dart';
import 'models/tenant.dart';
import 'edit_tenant_screen.dart';

class TenantDetailScreen extends StatefulWidget {
  const TenantDetailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TenantDetailScreenState createState() => _TenantDetailScreenState();
}

class _TenantDetailScreenState extends State<TenantDetailScreen> {
  late Tenant tenant;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the tenant from the arguments
    tenant = ModalRoute.of(context)!.settings.arguments as Tenant;
  }

  void _PaymentStatus(int month) {
    setState(() {
      // Marking the payment status
      tenant.paymentStatus[month - 1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenant Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between text and button
              children: [
                Text('Name: ${tenant.name}', style: const TextStyle(fontSize: 20)),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTenantScreen(tenant: tenant), // Pass tenant details to edit screen
                      ),
                    );
                  },
                ),
              ],
            ),
            Text('Rent Amount: \$${tenant.rent.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            const Text('Payment History:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded( // Use Expanded to allow ListView to take available space
              child: ListView.builder(
                itemCount: tenant.paymentStatus.length, // Number of months
                itemBuilder: (context, index) {
                  int month = index + 1; // Month number (1-based)
                  return ListTile(
                    title: Text('Month $month'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (tenant.paymentStatus[index]) // Check if this month is paid
                          SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              onPressed: () {
                                // Download receipt logic here
                              },
                              child: const Text('Download'),
                            ),
                          ),
                        IconButton(
                          icon:
                              Icon(tenant.paymentStatus[index] ? Icons.check_circle : Icons.error),
                          onPressed: () {
                            _PaymentStatus(month); // Toggle payment status
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}