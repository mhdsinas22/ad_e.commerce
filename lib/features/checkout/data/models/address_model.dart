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
    required super.name,
    required super.mobileNumber,
    required super.state,
    required super.district,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      pincode: json["pincode"] ?? "",
      house: json["house"] ?? "",
      area: json["area"] ?? "",
      landmark: json["landmark"] ?? "",
      alternatePhone: json["alternate_phone"] ?? "",
      email: json["email"] ?? "",
      saveAs: json["save_as"],
      userid: json["user_id"] ?? "",
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      mobileNumber: json["mobile_number"] ?? "",
      state: json["state"] ?? "",
      district: json["district"] ?? "",
    );
  }
  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      id: entity.id,
      userid: entity.userid,
      pincode: entity.pincode,
      house: entity.house,
      area: entity.area,
      landmark: entity.landmark,
      email: entity.email,
      alternatePhone: entity.alternatePhone,
      saveAs: entity.saveAs,
      name: entity.name,
      mobileNumber: entity.mobileNumber,
      state: entity.state,
      district: entity.district,
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
      "name": name,
      "mobile_number": mobileNumber,
      "state": state,
      "district": district,
    };
  }

  AddressModel copyWith({
    String? pincode,
    String? house,
    String? area,
    String? landmark,
    String? email,
    String? alternatePhone,
    String? saveAs,
    String? name,
    String? mobileNumber,
    String? state,
    String? district,
  }) {
    return AddressModel(
      id: id,
      userid: userid,
      pincode: pincode ?? this.pincode,
      house: house ?? this.house,
      area: area ?? this.area,
      landmark: landmark ?? this.landmark,
      email: email ?? this.email,
      alternatePhone: alternatePhone ?? this.alternatePhone,
      saveAs: saveAs ?? this.saveAs,
      name: name ?? this.name,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      state: state ?? this.state,
      district: district ?? this.district,
    );
  }
}
