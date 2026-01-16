import 'package:ad_e_commerce/features/product/domain/entites/product.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState {
  final ProductStatus productStatus;
  final List<Product> products;
  final List<Product> flashSaleProducts;
  final String? errorMessage;
  final int currentIndex;
  const ProductState({
    required this.productStatus,
    this.products = const [],
    this.errorMessage,
    this.flashSaleProducts = const [],
    this.currentIndex = 0,
  });
  factory ProductState.initial() =>
      const ProductState(productStatus: ProductStatus.initial);
  ProductState copyWith({
    ProductStatus? productStatus,
    List<Product>? products,
    String? errorMessage,
    List<Product>? flashSaleProducts,
    int? currentIndex,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
      flashSaleProducts: flashSaleProducts ?? this.flashSaleProducts,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
