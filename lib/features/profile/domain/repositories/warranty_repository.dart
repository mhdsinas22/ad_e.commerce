import 'package:ad_e_commerce/features/profile/data/models/warranty_model.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/warranty.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/warranty_card.dart';

abstract class WarrantyRepository {
  Future<WarrantyCard> createCard(WarrantyCard warranty);
  Future<List<WarrantyCard>> getWarranties();
  Future<void> createWarranty(WarrantyModel warrantyModel);
  Future<WarrantyCard?> getWarrantyCardByUser(String userId);
  Future<({WarrantyCard card, List<Warranty> warranties})?> getWarrantyData(
    String userId,
  );
}
