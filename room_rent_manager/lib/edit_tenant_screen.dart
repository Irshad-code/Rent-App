// lib/edit_tenant_screen.dart
import 'package:flutter/material.dart';
import 'models/tenant.dart';

class EditTenantScreen extends StatefulWidget {
  final Tenant tenant;

  const EditTenantScreen({super.key, required this.tenant});

  @override
  // ignore: library_private_types_in_public_api
  _EditTenantScreenState createState() => _EditTenantScreenState();
}

class _EditTenantScreenState extends State<EditTenantScreen> {
  late TextEditingController nameController;
  late TextEditingController rentController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.tenant.name);
    rentController = TextEditingController(text: widget.tenant.rent.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    rentController.dispose();
    super.dispose();
  }

void _saveChanges() {
  // Update tenant details
  widget.tenant.name = nameController.text;
  widget.tenant.rent = double.tryParse(rentController.text) ?? widget.tenant.rent;

  // Pass back updated tenant object
  Navigator.pop(context, widget.tenant); // Pass updated tenant
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Tenant')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: rentController,
              decoration: const InputDecoration(labelText: 'Rent Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}