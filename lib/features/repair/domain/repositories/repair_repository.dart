import 'package:flutter/foundation.dart';

import '../entities/repair_request_entity.dart';

abstract class RepairRepository {
  Future<void> submitRepairRequest({
    required RepairRequestEntity request,
    required List<Uint8List> images,
  });
}
