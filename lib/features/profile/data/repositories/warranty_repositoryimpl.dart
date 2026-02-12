import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/warranty_remote_datasource.dart';
import 'package:ad_e_commerce/features/profile/data/models/warranty_model.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/warranty.dart';
import 'package:ad_e_commerce/features/profile/domain/repositories/warranty_repository.dart';

class WarrantyRepositoryimpl implements WarrantyRepository {
  final WarrantyRemoteDatasource warrantyRemoteDatasource;
  WarrantyRepositoryimpl(this.warrantyRemoteDatasource);
  @override
  Future<void> createWarranty(Warranty warranty) async {
    try {
      return await warrantyRemoteDatasource.createWarranty(
        warranty as WarrantyModel,
      );
    } catch (e) {
      AppLogger.error("Error creating warranty:${e.toString()}");
    }
  }

  @override
  Future<List<Warranty>> getWarranties(String userId) async {
    try {
      return await warrantyRemoteDatasource.getWarranties(userId);
    } catch (e) {
      AppLogger.error("GET ERROR:_${e.toString()}");
      return [];
    }
  }
}
