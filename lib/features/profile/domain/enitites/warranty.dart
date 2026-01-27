class Warranty {
  final String? id;
  final String warrantyCode;
  final String userid;
  final String product;
  final String imeiSerial;
  final String planType;
  final String specificPlan;
  final DateTime startDate;
  final DateTime expiryDate;
  final String status;

  Warranty({
    this.id,
    required this.warrantyCode,
    required this.userid,
    required this.startDate,
    required this.expiryDate,
    required this.status,
    required this.imeiSerial,
    required this.planType,
    required this.product,
    required this.specificPlan,
  });
}
