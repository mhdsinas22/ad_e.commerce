class AddressEntity {
  final String pincode;
  final String house;
  final String area;
  final String? landmark;
  final String email;
  final String? alternatePhone;
  final String saveAs;
  final String? id;
  final String? userid;

  AddressEntity({
    required this.pincode,
    required this.house,
    required this.area,
    this.landmark,
    required this.email,
    this.alternatePhone,
    required this.saveAs,
    this.id,
    this.userid,
  });
}
