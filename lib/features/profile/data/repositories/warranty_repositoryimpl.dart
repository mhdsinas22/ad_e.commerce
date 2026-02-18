import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/warranty_remote_datasource.dart';
import 'package:ad_e_commerce/features/profile/data/models/warranty_card_mode.dart';
import 'package:ad_e_commerce/features/profile/data/models/warranty_model.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/warranty.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/warranty_card.dart';
import 'package:ad_e_commerce/features/profile/domain/repositories/warranty_repository.dart';

class WarrantyRepositoryimpl implements WarrantyRepository {
  final WarrantyRemoteDatasource warrantyRemoteDatasource;
  WarrantyRepositoryimpl(this.warrantyRemoteDatasource);
  @override
  Future<WarrantyCard> createCard(WarrantyCard warranty) async {
    try {
      return await warrantyRemoteDatasource.createCard(
        WarrantyCardModel.fromEntity(warranty),
        warranty.userid,
      );
    } catch (e) {
      AppLogger.error("Error creating warranty:${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<List<WarrantyCard>> getWarranties() async {
    try {
      return await warrantyRemoteDatasource.getWarranties();
    } catch (e) {
      AppLogger.error("GET ERROR:_${e.toString()}");
      return [];
    }
  }

  @override
  Future<void> createWarranty(WarrantyModel warrantyModel) async {
    try {
      return await warrantyRemoteDatasource.createWarranty(warrantyModel);
    } catch (e) {
      AppLogger.error("Error creating warranty:${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<WarrantyCard?> getWarrantyCardByUser(String userId) async {
    try {
      return await warrantyRemoteDatasource.getWarrantyCardByUser(userId);
    } catch (e) {
      AppLogger.error("GET WARRANTY:_${e.toString()}");
      return null;
    }
  }

  @override
  Future<({WarrantyCard card, List<Warranty> warranties})?> getWarrantyData(
    String userId,
  ) async {
    try {
      final result = await warrantyRemoteDatasource.getWarrantyData(userId);
      if (result == null) return null;
      return (card: result.card, warranties: result.warranties);
    } catch (e) {
      AppLogger.error("GET WARRANTY DATA ERROR:${e.toString()}");
      rethrow;
    }
  }
}
