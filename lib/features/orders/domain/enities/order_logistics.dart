class OrderLogistics {
  final String? id;
  final String orderId;
  final String courierPartner;
  final String pickupLocation;
  final String trackingNumber;
  final DateTime pickupDate;

  OrderLogistics({
    this.id,
    required this.orderId,
    required this.courierPartner,
    required this.pickupLocation,
    required this.trackingNumber,
    required this.pickupDate,
  });
}
