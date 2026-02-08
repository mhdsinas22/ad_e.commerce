// product_warranty_repository.dart

import 'package:ad_e_commerce/features/product/domain/entites/product_warranty.dart';

abstract class ProductWarrantyRepository {
  /// Add warranties for a product
  Future<void> insertProductWarranties(List<ProductWarranty> warranties);

  /// Get warranties of a product
  Future<List<ProductWarranty>> getProductWarranties(String productId);

  /// Remove all warranties of a product
  Future<void> deleteProductWarranties(String productId);
}
