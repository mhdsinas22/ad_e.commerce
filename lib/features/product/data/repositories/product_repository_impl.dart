import 'package:ad_e_commerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:ad_e_commerce/features/home/domain/enitites/models/product_model.dart';
import 'package:ad_e_commerce/features/home/domain/enitites/models/product_stock_model.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product_stock.dart';
import 'package:ad_e_commerce/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remote;
  ProductRepositoryImpl(this.remote);
  @override
  Future<void> addProduct(Product product) async {
    final model = ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      condition: product.condition,
      price: product.price,
      originalPrice: product.originalPrice,
      warrantyMonths: product.warrantyMonths,
      isActive: product.isActive,
      color: product.color,
      category: product.category,
      imageUrls: product.imageUrls,
      ram: product.ram,
      storageid: product.storageid,
      tag: product.tag,
      modelNumber: product.modelNumber,
      conditionType: product.conditionType,
      stocks: product.stocks,
      storage: product.storage,
      categoryid: product.categoryid,
      conditiontypeid: product.categoryid,
      colorid: product.colorid,
      rating: product.rating,
      noofreviews: product.noofreviews,
      ramid: product.ramid,
      subCategory: product.subCategory,
    );
    return remote.addProduct(model);
  }

  @override
  Future<void> updateProduct(Product product) async {
    final model = ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      condition: product.condition,
      price: product.price,
      originalPrice: product.originalPrice,
      warrantyMonths: product.warrantyMonths,
      isActive: product.isActive,
      color: product.color,
      category: product.category,
      imageUrls: product.imageUrls,
      ram: product.ram,
      storageid: product.storageid,
      tag: product.tag,
      modelNumber: product.modelNumber,
      conditionType: product.conditionType,
      stocks: product.stocks,
      storage: product.storage,
      categoryid: product.categoryid,
      conditiontypeid: product.categoryid,
      colorid: product.colorid,
      rating: product.rating,
      noofreviews: product.noofreviews,
      ramid: product.ramid,
      subCategory: product.subCategory,
    );
    return remote.updateProduct(model);
  }

  @override
  Future<void> deleteProduct(String productId) async {
    return remote.deleteProduct(productId);
  }

  @override
  Future<List<Product>> getproducts() async {
    final models = await remote.getProducts();

    return models.map((model) {
      return Product(
        id: model.id,
        title: model.title,
        description: model.description,
        stocks: model.stocks,
        category: model.category,

        condition: model.condition.isNotEmpty ? model.condition : 'unknown',
        conditionType:
            model.conditionType.isNotEmpty ? model.conditionType : "",
        color: model.color,
        price: model.price,
        originalPrice: model.originalPrice,
        warrantyMonths: model.warrantyMonths,
        isActive: model.isActive,

        modelNumber: model.modelNumber,
        storageid: model.storageid,
        ram: model.ram,
        tag: model.tag,
        storage: model.storage,
        categoryid: model.categoryid,
        conditiontypeid: model.categoryid,
        colorid: model.colorid,
        rating: model.rating,
        noofreviews: model.noofreviews,
        ramid: model.ramid,
        imageUrls: List<String>.from(model.imageUrls),
        subCategory: model.subCategory,
        warranties: model.warranties,
      );
    }).toList();
  }

  @override
  Future<void> addProductStocks(List<ProductStock> stocks) async {
    final models =
        stocks.map((productstock) {
          return ProductStockModel(
            productId: productstock.productId,
            storeName: productstock.storeName,
            quantity: productstock.quantity,
          );
        }).toList();
    return remote.addProductStocks(models);
  }

  @override
  Future<List<Map<String, dynamic>>> getProductsWithStocks() {
    return remote.getProductsWithStocks();
  }

  @override
  Future<void> updateProductStocks(List<ProductStock> stocks) async {
    final models =
        stocks.map((productstock) {
          return ProductStockModel(
            productId: productstock.productId,
            storeName: productstock.storeName,
            quantity: productstock.quantity,
          );
        }).toList();

    return remote.updateProductStocks(models);
  }

  @override
  Future<List<Product>> getFlashSaleProducts() {
    return remote.getFlashSaleProducts();
  }
}
