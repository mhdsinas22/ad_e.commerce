import 'package:aerstore/core/error/exceptions.dart';
import 'package:aerstore/features/home/data/datasource/banner_remote_datasource.dart';
import 'package:aerstore/features/home/models/banner_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final SupabaseClient client;

  BannerRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await client
          .from('banners')
          .select()
          .order('created_at', ascending: false);
      return (response as List).map((e) => BannerModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> saveBannerImages(BannerModel banner) async {
    try {
      if (banner.id != null) {
        // Update existing
        await client
            .from('banners')
            .update({'image_url': banner.imageUrl})
            .eq('id', banner.id!);
      } else {
        // Insert new
        await client.from('banners').insert(banner.toJson());
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> removeBannerImage(String id, List<String> updatedImages) async {
    try {
      await client
          .from('banners')
          .update({'image_url': updatedImages})
          .eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateBannerStatus(String id, bool isActive) async {
    try {
      await client.from("banners").update({"is_active": isActive}).eq("id", id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteBanner(String id) async {
    try {
      await client.from("banners").delete().eq("id", id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
