import 'dart:io';
import '../entities/repair_request_entity.dart';

abstract class RepairRepository {
  Future<void> submitRepairRequest({
    required RepairRequestEntity request,
    required List<File> images,
  });
}
