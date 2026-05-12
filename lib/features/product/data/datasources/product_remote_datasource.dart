import 'package:aerstore/features/home/domain/enitites/models/product_model.dart';
import 'package:aerstore/features/home/domain/enitites/models/product_stock_model.dart';
import 'package:aerstore/features/product/domain/entites/product.dart';

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
