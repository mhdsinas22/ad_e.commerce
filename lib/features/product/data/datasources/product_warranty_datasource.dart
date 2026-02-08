import 'package:ad_admin_side/features/product/data/models/warranty/prodcut_warranty_model.dart';

abstract class ProductWarrantyRemoteDataSource {
  /// Add multiple warranties for a product
  Future<void> insertProductWarranties(List<ProductWarrantyModel> warranties);

  /// Get warranties by product id
  Future<List<ProductWarrantyModel>> getProductWarranties(String productId);

  /// Delete all warranties of a product (edit case)
  Future<void> deleteProductWarranties(String productId);
}
