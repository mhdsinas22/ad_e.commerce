import 'package:ad_e_commerce/features/profile/domain/enitites/warranty.dart';

abstract class WarrantyRepository {
  Future<void> createWarranty(Warranty warranty);
  Future<List<Warranty>> getWarranties(String userId);
}
