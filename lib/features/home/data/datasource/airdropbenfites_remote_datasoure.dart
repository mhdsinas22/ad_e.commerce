import 'package:aerstore/features/home/models/airdropbenfites_model.dart';
import 'package:aerstore/features/home/domain/enitites/airdropbenfites_entity.dart';

abstract class AirdropbenfitesRemoteDatasoure {
  Future<List<AirdropbenfitesEntity>> getairdropBanners();
  Future<void> saveairdropBannerImages(AirdropbenfitesModel airdropbenfites);
  Future<void> removeairdropBannerImage(String id, List<String> updatedImages);
  Future<void> updateairdropStatus(String id, bool isActive);
  Future<void> deleteairdropBanner(String id);
}
