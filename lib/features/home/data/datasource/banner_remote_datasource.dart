import 'package:ad_e_commerce/features/home/models/banner_model.dart';

abstract class BannerRemoteDataSource {
  Future<List<BannerModel>> getBanners();
  Future<void> saveBannerImages(BannerModel banner);
  Future<void> removeBannerImage(String id, List<String> updatedImages);
  Future<void> updateBannerStatus(String id, bool isActive);
  Future<void> deleteBanner(String id);
}
