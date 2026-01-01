import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/repair_request_model.dart';

abstract class RepairRemoteDataSource {
  Future<String> uploadRepairImage(File imageFile);
  Future<void> submitRepairRequest(RepairRequestModel request);
}

class RepairRemoteDataSourceImpl implements RepairRemoteDataSource {
  final SupabaseClient supabase;

  RepairRemoteDataSourceImpl(this.supabase);

  @override
  Future<String> uploadRepairImage(File imageFile) async {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${imageFile.uri.pathSegments.last}';
    // Best Practice: structure by userId (if available) or date/feature
    // Since we don't have userId injected here easily, using feature folder
    final path = 'repair_photos/$fileName';

    await supabase.storage
        .from('repair_photos')
        .upload(
          path,
          imageFile,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    final imageUrl = supabase.storage.from('repair_photos').getPublicUrl(path);
    return imageUrl;
  }

  @override
  Future<void> submitRepairRequest(RepairRequestModel request) async {
    await supabase.from('repair_requests').insert(request.toJson());
  }
}
