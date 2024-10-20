// lib/tenant_overview_screen.dart
import 'package:flutter/material.dart';
import 'package:room_rent_manager/tenant_detail_screen.dart';
import 'models/tenant.dart';

class TenantOverviewScreen extends StatefulWidget {
  const TenantOverviewScreen({super.key});

  @override
  State<TenantOverviewScreen> createState() => _TenantOverviewScreenState();
}

class _TenantOverviewScreenState extends State<TenantOverviewScreen> {
  List<Tenant> tenants = [
    Tenant(number: 1, name: 'John Doe', rent: 500.0, dueAmount: 200.0),
    Tenant(number: 2, name: 'Jane Smith', rent: 600.0, dueAmount: 0.0, isPaid: true),
    // Add more tenants as needed
  ];
  
  List<Tenant> filteredTenants = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredTenants = tenants; // Initially show all tenants
  }

  void _filterTenants(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredTenants = tenants; // Show all tenants if query is empty
      } else {
        filteredTenants = tenants.where((tenant) =>
            tenant.name.toLowerCase().contains(query.toLowerCase())).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tenant Overview')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _filterTenants,
                decoration: const InputDecoration(
                  hintText: 'Search Tenants',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: filteredTenants.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredTenants.length,
                      itemBuilder: (context, index) {
                        final tenant = filteredTenants[index];
                        return ListTile(
                          title: Text(tenant.name),
                          subtitle: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16, // Default font size for both parts
                                color: Colors.black, // Default color for the label
                              ),
                              children: [
                                TextSpan(
                                  text: 'Rent Amount: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal, // Normal weight for the label
                                    color: Colors.black, // Color for the label
                                  ),
                                ),
                                TextSpan(
                                  text: '\$${tenant.rent.toStringAsFixed(2)}', // Rent amount
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold, // Bold weight for the amount
                                    color: Colors.green, // Green color for the amount
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            // Navigate to TenantDetailScreen when tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TenantDetailScreen(),
                                settings: RouteSettings(arguments: tenant),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : const Center(child: Text('No tenants found')), // Show message if no results
            ),
          ],
        ),
      ),
    );
  }
}