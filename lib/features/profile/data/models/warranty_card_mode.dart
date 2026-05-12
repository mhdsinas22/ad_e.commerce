import 'package:aerstore/features/profile/domain/enitites/warranty_card.dart';

class WarrantyCardModel extends WarrantyCard {
  WarrantyCardModel({
    super.id,
    required super.warrantyCode,
    required super.userid,
  });
  static WarrantyCardModel fromEntity(WarrantyCard entity) {
    return WarrantyCardModel(
      id: entity.id,
      warrantyCode: entity.warrantyCode,
      userid: entity.userid,
    );
  }

  factory WarrantyCardModel.fromJson(Map<String, dynamic> json) {
    return WarrantyCardModel(
      id: json["id"],
      warrantyCode: json["warranty_code"],
      userid: json["user_id"],
    );
  }
  Map<String, dynamic> toJson() {
    return {"user_id": userid, "warranty_code": warrantyCode};
  }
}
