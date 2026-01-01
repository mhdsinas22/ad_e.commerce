import 'package:equatable/equatable.dart';

class RepairRequestEntity extends Equatable {
  final String? id;
  final String brand;
  final List<String> services;
  final String deviceModel;
  final String complaintDescription;
  final List<String> imageUrls;
  final String name;
  final String mobileNumber;
  final String email;
  final String location;
  final DateTime createdAt;

  const RepairRequestEntity({
    this.id,
    required this.brand,
    required this.services,
    required this.deviceModel,
    required this.complaintDescription,
    required this.imageUrls,
    required this.name,
    required this.mobileNumber,
    required this.email,
    required this.location,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    brand,
    services,
    deviceModel,
    complaintDescription,
    imageUrls,
    name,
    mobileNumber,
    email,
    location,
    createdAt,
  ];
}
