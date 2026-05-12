import 'package:aerstore/core/error/exceptions.dart';
import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/home/data/datasource/airdropbenfites_remote_datasoure.dart';
import 'package:aerstore/features/home/models/airdropbenfites_model.dart';
import 'package:aerstore/features/home/domain/enitites/airdropbenfites_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AirdropbenfitesRemoteDatasoureimpl
    implements AirdropbenfitesRemoteDatasoure {
  final SupabaseClient client;

  AirdropbenfitesRemoteDatasoureimpl({required this.client});

  @override
  Future<List<AirdropbenfitesEntity>> getairdropBanners() async {
    try {
      final response = await client.from('airdropbenfitsbanners').select();

      return (response as List)
          .map((e) => AirdropbenfitesModel.fromJson(e))
          .toList();
    } catch (e) {
      AppLogger.error("REAL ERROR: $e");
      final ServerException ser = ServerException(e.toString());

      throw ser;
    }
  }

  @override
  Future<void> saveairdropBannerImages(
    AirdropbenfitesModel airdropbenfites,
  ) async {
    try {
      if (airdropbenfites.id != null) {
        // Update existing
        await client
            .from('airdropbenfitsbanners')
            .update({'image_url': airdropbenfites.imageUrl})
            .eq('id', airdropbenfites.id!);
      } else {
        // Insert new
        await client
            .from('airdropbenfitsbanners')
            .insert(airdropbenfites.toJson());
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> removeairdropBannerImage(
    String id,
    List<String> updatedImages,
  ) async {
    try {
      await client
          .from('airdropbenfitsbanners')
          .update({'image_url': updatedImages})
          .eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateairdropStatus(String id, bool isActive) async {
    try {
      await client
          .from("airdropbenfitsbanners")
          .update({"is_active": isActive})
          .eq("id", id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteairdropBanner(String id) async {
    try {
      await client.from("airdropbenfitsbanners").delete().eq("id", id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
