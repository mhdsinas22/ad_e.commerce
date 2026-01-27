import 'package:ad_e_commerce/features/profile/domain/enitites/warranty.dart';

class WarrantyModel extends Warranty {
  WarrantyModel({
    super.id,
    required super.warrantyCode,
    required super.userid,
    required super.imeiSerial,
    required super.planType,
    required super.product,
    required super.specificPlan,
    required super.startDate,
    required super.expiryDate,
    required super.status,
  });
  factory WarrantyModel.fromJson(Map<String, dynamic> json) {
    return WarrantyModel(
      id: json["id"],
      warrantyCode: json["warranty_code"],
      userid: json["user_id"],
      product: json["product"],
      imeiSerial: json["imei_serial"],
      planType: json["plan_type"],
      specificPlan: json["select_specific_plan"],
      startDate: DateTime.parse(json['start_date']),
      expiryDate: DateTime.parse(json['expiry_date']),
      status: json["status"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "user_id": userid,
      "warranty_code": warrantyCode,
      "product": product,
      "imei_serial": imeiSerial,
      "plan_type": planType,
      "select_specific_plan": specificPlan,
      "start_date": startDate.toIso8601String(),
      "expiry_date": expiryDate.toIso8601String(),
      "status": status,
    };
  }
}
