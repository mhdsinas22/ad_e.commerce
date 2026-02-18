class WarrantyCard {
  final String? id;
  final String warrantyCode;
  final String userid;

  WarrantyCard({this.id, required this.warrantyCode, required this.userid});
  WarrantyCard copyWith({String? id, String? warrantyCode, String? userid}) {
    return WarrantyCard(
      id: id ?? this.id,
      warrantyCode: warrantyCode ?? this.warrantyCode,
      userid: userid ?? this.userid,
    );
  }
}
