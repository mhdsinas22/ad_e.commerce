import 'package:aerstore/features/repair/data/datasources/repair_storage_service.dart';
import 'package:aerstore/features/repair/data/datasources/repair_remote_data_source.dart';
import 'package:aerstore/features/repair/data/models/repair_request_model.dart';
import 'package:aerstore/features/repair/domain/entities/repair_request_entity.dart';
import 'package:aerstore/features/repair/domain/repositories/repair_repository.dart';
import 'package:flutter/foundation.dart';

class RepairRepositoryImpl implements RepairRepository {
  final RepairRemoteDataSource remoteDataSource;
  final RepairStorageService checkRepairStorageService;

  RepairRepositoryImpl(this.remoteDataSource, this.checkRepairStorageService);

  @override
  Future<void> submitRepairRequest({
    required RepairRequestEntity request,
    required List<Uint8List> images,
  }) async {
    final List<String> imageUrls = [];

    // 1. Upload all images
    for (final image in images) {
      final url = await checkRepairStorageService.uploadRepairImageBytes(
        bytes: image,
        userId: request.userid,
      );
      imageUrls.add(url);
    }

    // 2. Create Model with Image URLs
    final repairRequestModel = RepairRequestModel(
      id: request.id,
      userid: request.userid,
      brand: request.brand,
      services: request.services,
      deviceModel: request.deviceModel,
      complaintDescription: request.complaintDescription,
      imageUrls: imageUrls,
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
