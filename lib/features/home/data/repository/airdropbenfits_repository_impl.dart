import 'package:aerstore/features/home/data/datasource/airdropbenfites_remote_datasoure.dart';
import 'package:aerstore/features/home/models/airdropbenfites_model.dart';
import 'package:aerstore/features/home/domain/enitites/airdropbenfites_entity.dart';
import 'package:aerstore/features/home/domain/repositories/airdropbenfits_repository.dart';

import '../../../../core/error/exceptions.dart';

class AirdropbenfitsRepositoryImpl implements AirdropbenfitsRepository {
  final AirdropbenfitesRemoteDatasoure remoteDataSource;

  AirdropbenfitsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AirdropbenfitesEntity>> getairdropBanners() async {
    try {
      final banners = await remoteDataSource.getairdropBanners();
      return banners;
    } catch (e) {
      return throw ServerException(e.toString());
    }
  }

  @override
  Future<void> saveairdropBannerImages(
    AirdropbenfitesEntity airdropbenfitesEnitity,
  ) async {
    try {
      await remoteDataSource.saveairdropBannerImages(
        AirdropbenfitesModel(
          id: airdropbenfitesEnitity.id,
          imageUrl: airdropbenfitesEnitity.imageUrl,
          isActive: airdropbenfitesEnitity.isActive,
        ),
      );
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
      await remoteDataSource.removeairdropBannerImage(id, updatedImages);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateairdropStatus(String id, bool isActive) async {
    return remoteDataSource.updateairdropStatus(id, isActive);
  }

  @override
  Future<void> deleteairdropBanner(String id) async {
    try {
      await remoteDataSource.deleteairdropBanner(id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
