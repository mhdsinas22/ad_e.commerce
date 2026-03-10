class Warranty {
  final String? id;
  final String warrantyCardid;
  final DateTime startdate;
  final DateTime expirydate;
  final String status;
  final String planType;
  final String specificPlan;
  final String product;
  final String imeiSerial;
  final String? orderNumber;
  final String? repairCode;
  final String? displayName;
  final String? type;
  final String? coverageType;
  Warranty({
    this.id,
    required this.warrantyCardid,
    required this.startdate,
    required this.expirydate,
    required this.status,
    required this.planType,
    required this.specificPlan,
    required this.product,
    required this.imeiSerial,
    this.orderNumber,
    this.repairCode,
    this.displayName,
    this.type,
    this.coverageType,
  });
  Warranty copyWith({
    String? id,
    String? warrantyCardid,
    DateTime? startdate,
    DateTime? expirydate,
    String? status,
    String? planType,
    String? specificPlan,
    String? product,
    String? imeiSerial,
    String? orderNumber,
    String? repairCode,
    String? displayName,
    String? type,
    String? coverageType,
  }) {
    return Warranty(
      id: id ?? this.id,
      warrantyCardid: warrantyCardid ?? this.warrantyCardid,
      startdate: startdate ?? this.startdate,
      expirydate: expirydate ?? this.expirydate,
      status: status ?? this.status,
      planType: planType ?? this.planType,
      specificPlan: specificPlan ?? this.specificPlan,
      product: product ?? this.product,
      imeiSerial: imeiSerial ?? this.imeiSerial,
      orderNumber: orderNumber ?? this.orderNumber,
      repairCode: repairCode ?? this.repairCode,
      displayName: displayName ?? this.displayName,
      type: type ?? this.type,
      coverageType: coverageType ?? this.coverageType,
    );
  }
}
