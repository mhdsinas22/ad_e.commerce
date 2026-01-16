import 'package:ad_e_commerce/features/product/data/models/product_model.dart';
import 'package:ad_e_commerce/features/product/data/models/product_stock_model.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';

abstract class ProductRemoteDatasource {
  Future<void> addProduct(ProductModel model);
  Future<void> updateProduct(ProductModel model);
  Future<void> deleteProduct(String id);
  Future<List<ProductModel>> getProducts();
  Future<void> addProductStocks(List<ProductStockModel> stocks);
  Future<void> updateProductStocks(List<ProductStockModel> stocks); // ✅ NEW
  Future<void> deleteProductStocks(String productId);
  Future<List<ProductStockModel>> getProductStocks(String productId);
  Future<List<Map<String, dynamic>>> getProductsWithStocks();
  Future<List<Product>> getFlashSaleProducts();
}
