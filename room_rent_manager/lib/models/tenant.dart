// lib/models/tenant.dart
class Tenant {
  final int number;
  String name;
  double rent;
  double dueAmount;
  bool isPaid;
  List<bool> paymentStatus;

  Tenant({
    required this.number,
    required this.name,
    required this.rent,
    this.dueAmount = 0,
    this.isPaid = false,
     List<bool>? paymentStatus,
  }) : paymentStatus = paymentStatus ?? List.filled(5, false); // Initialize with 23 months as unpaid
}
