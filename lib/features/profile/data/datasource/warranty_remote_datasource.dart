import 'package:aerstore/features/profile/data/models/warranty_card_mode.dart';
import 'package:aerstore/features/profile/data/models/warranty_model.dart';
import 'package:aerstore/features/profile/domain/enitites/wallet/warranty.dart';

abstract class WarrantyRemoteDatasource {
  Future<WarrantyCardModel> createCard(
    WarrantyCardModel warrantyModel,
    String userId,
  );
  Future<List<WarrantyCardModel>> getWarranties();
  Future<void> createWarranty(WarrantyModel warrantyModel);
  Future<WarrantyCardModel?> getWarrantyCardByUser(String userId);
  Future<List<Warranty>> getWarrantiesByCardId(String cardId);
  Future<({WarrantyCardModel card, List<WarrantyModel> warranties})?>
  getWarrantyData(String userId);
}
