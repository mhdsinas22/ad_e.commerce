import 'package:ad_e_commerce/features/home/domain/enitites/banner_entity.dart';

abstract class BannerRepository {
  Future<List<BannerEntity>> getBanners();
  Future<void> saveBannerImages(BannerEntity banner);
  Future<void> removeBannerImage(String id, List<String> updatedImages);
  Future<void> updateStatus(String id, bool isActive);
  Future<void> deleteBanner(String id);
}
