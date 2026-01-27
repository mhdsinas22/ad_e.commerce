import 'package:ad_e_commerce/features/profile/data/models/warranty_model.dart';

abstract class WarrantyRemoteDatasource {
  Future<void> createWarranty(WarrantyModel warrantyModel);
  Future<List<WarrantyModel>> getWarranties(String userId);
}
