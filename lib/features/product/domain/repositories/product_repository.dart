import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product_stock.dart';

abstract class ProductRepository {
  Future<void> addProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String productid);
  Future<List<Product>> getproducts();
  Future<void> addProductStocks(List<ProductStock> stocks);
  Future<List<Map<String, dynamic>>> getProductsWithStocks();
  Future<void> updateProductStocks(List<ProductStock> stocks);
  Future<List<Product>> getFlashSaleProducts();
}
