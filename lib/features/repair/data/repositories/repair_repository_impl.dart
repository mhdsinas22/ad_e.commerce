import 'dart:io';

import 'package:ad_e_commerce/features/repair/data/datasources/repair_remote_data_source.dart';
import 'package:ad_e_commerce/features/repair/data/models/repair_request_model.dart';
import 'package:ad_e_commerce/features/repair/domain/entities/repair_request_entity.dart';
import 'package:ad_e_commerce/features/repair/domain/repositories/repair_repository.dart';

class RepairRepositoryImpl implements RepairRepository {
  final RepairRemoteDataSource remoteDataSource;

  RepairRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> submitRepairRequest({
    required RepairRequestEntity request,
    required List<File> images,
  }) async {
    final List<String> imageUrls = [];

    // 1. Upload all images
    for (final image in images) {
      final url = await remoteDataSource.uploadRepairImage(image);
      imageUrls.add(url);
    }

    // 2. Create Model with Image URLs
    final repairRequestModel = RepairRequestModel(
      id: request.id,
      brand: request.brand,
      services: request.services,
      deviceModel: request.deviceModel,
      complaintDescription: request.complaintDescription,
      imageUrls: [],
      name: request.name,
      mobileNumber: request.mobileNumber,
      email: request.email,
      location: request.location,
      createdAt: request.createdAt,
    );

    // 3. Submit Request
    await remoteDataSource.submitRepairRequest(repairRequestModel);
  }
}
