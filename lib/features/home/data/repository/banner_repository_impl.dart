import 'package:ad_e_commerce/features/home/models/banner_model.dart';
import 'package:ad_e_commerce/features/home/domain/enitites/banner_entity.dart';
import 'package:ad_e_commerce/features/home/domain/repositories/banner_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../datasource/banner_remote_datasource.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource remoteDataSource;

  BannerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<BannerEntity>> getBanners() async {
    try {
      final banners = await remoteDataSource.getBanners();
      return banners;
    } catch (e) {
      return throw ServerException(e.toString());
    }
  }

  @override
  Future<void> saveBannerImages(BannerEntity banner) async {
    try {
      await remoteDataSource.saveBannerImages(
        BannerModel(
          id: banner.id,
          imageUrl: banner.imageUrl,
          isActive: banner.isActive,
        ),
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> removeBannerImage(String id, List<String> updatedImages) async {
    try {
      await remoteDataSource.removeBannerImage(id, updatedImages);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateStatus(String id, bool isActive) async {
    return remoteDataSource.updateBannerStatus(id, isActive);
  }

  @override
  Future<void> deleteBanner(String id) async {
    try {
      await remoteDataSource.deleteBanner(id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
