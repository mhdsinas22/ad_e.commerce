import 'package:aerstore/features/profile/domain/enitites/wallet/warranty.dart';

class WarrantyModel extends Warranty {
  WarrantyModel({
    super.id,
    required super.warrantyCardid,
    required super.startdate,
    required super.expirydate,
    required super.status,
    required super.planType,
    required super.specificPlan,
    required super.product,
    required super.imeiSerial,
    super.orderNumber,
    super.repairCode,
    super.displayName,
    super.type,
    super.coverageType,
  });

  @override
  WarrantyModel copyWith({
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
    return WarrantyModel(
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

  static WarrantyModel fromEntity(Warranty entity) {
    return WarrantyModel(
      id: entity.id,
      warrantyCardid: entity.warrantyCardid,
      startdate: entity.startdate,
      expirydate: entity.expirydate,
      status: entity.status,
      planType: entity.planType,
      specificPlan: entity.specificPlan,
      product: entity.product,
      imeiSerial: entity.imeiSerial,
      orderNumber: entity.orderNumber,
      repairCode: entity.repairCode,
      displayName: entity.displayName,
      type: entity.type,
      coverageType: entity.coverageType,
    );
  }

  factory WarrantyModel.fromJson(Map<String, dynamic> json) {
    return WarrantyModel(
      id: json["id"],
      warrantyCardid: json["warranty_card_id"],
      startdate: DateTime.parse(json["start_date"]),
      expirydate: DateTime.parse(json["expiry_date"]),
      status: json["status"],
      planType: json["plan_type"],
      specificPlan: json["selected_specific_plan"],
      product: json["product"],
      imeiSerial: json["imei_serial"],
      orderNumber: json["order_number"],
      repairCode: json["repair_code"],
      displayName: json["display_name"],
      type: json["type"],
      coverageType: json["warranty_coverage"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "warranty_card_id": warrantyCardid,
      "start_date": startdate.toIso8601String(),
      "expiry_date": expirydate.toIso8601String(),
      "status": status,
      "plan_type": planType,
      "selected_specific_plan": specificPlan,
      "product": product,
      "imei_serial": imeiSerial,
      "warranty_coverage": coverageType,
    };
  }
}
