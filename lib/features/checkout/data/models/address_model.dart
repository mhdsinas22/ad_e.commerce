import 'package:ad_e_commerce/features/checkout/domain/enitites/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.pincode,
    required super.house,
    required super.area,
    super.landmark,
    required super.email,
    super.alternatePhone,
    required super.saveAs,
    super.userid,
    super.id,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      pincode: json["pincode"],
      house: json["house"],
      area: json["area"],
      landmark: json["landmark"],
      alternatePhone: json["alternate_phone"],
      email: json["email"],
      saveAs: json["save_as"],
      userid: json["user_id"],
      id: json["id"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "pincode": pincode,
      "house": house,
      "area": area,
      "landmark": landmark,
      "alternate_phone": alternatePhone,
      "email": email,
      "user_id": userid,
      "save_as": saveAs,
    };
  }
}
