import 'package:ad_e_commerce/features/home/domain/enitites/airdropbenfites_entity.dart';

abstract class AirdropbenfitsRepository {
  Future<List<AirdropbenfitesEntity>> getairdropBanners();
  Future<void> saveairdropBannerImages(
    AirdropbenfitesEntity airdropbenfitesEntity,
  );
  Future<void> removeairdropBannerImage(String id, List<String> updatedImages);
  Future<void> updateairdropStatus(String id, bool isActive);
  Future<void> deleteairdropBanner(String id);
}
