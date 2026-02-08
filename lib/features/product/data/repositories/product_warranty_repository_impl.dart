import 'package:ad_e_commerce/features/product/data/datasources/product_warranty_datasource_impl.dart';
import 'package:ad_e_commerce/features/product/data/models/prodcut_warranty_model.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product_warranty.dart';
import 'package:ad_e_commerce/features/product/domain/repo/product_warranty_repository.dart';

class ProductWarrantyRepositoryImpl implements ProductWarrantyRepository {
  final ProductWarrantyRemoteDataSourceImpl remote;
  ProductWarrantyRepositoryImpl(this.remote);
  @override
  Future<void> insertProductWarranties(List<ProductWarranty> warranties) async {
    final models =
        warranties.map((e) {
          return ProductWarrantyModel(
            id: e.id,
            productId: e.productId,
            warrantyTypeId: e.warrantyTypeId,
            startDate: e.startDate,
            endDate: e.endDate,
            durationText: e.durationText,
          );
        }).toList();
    return await remote.insertProductWarranties(models);
  }

  @override
  Future<List<ProductWarrantyModel>> getProductWarranties(
    String productId,
  ) async {
    return await remote.getProductWarranties(productId);
  }

  @override
  Future<void> deleteProductWarranties(String productId) async {
    return await remote.deleteProductWarranties(productId);
  }
}
