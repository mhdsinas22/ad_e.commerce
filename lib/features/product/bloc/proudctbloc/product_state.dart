import 'package:aerstore/features/product/domain/entites/product.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState {
  final ProductStatus productStatus;
  final List<Product> products;
  final List<Product> flashSaleProducts;
  final String? errorMessage;
  final int currentIndex;
  final String selectedCondition;
  final String? selectedWarranty;
  const ProductState({
    required this.productStatus,
    this.products = const [],
    this.errorMessage,
    this.flashSaleProducts = const [],
    this.currentIndex = 0,
    this.selectedCondition = "Select Condition",
    this.selectedWarranty,
  });
  factory ProductState.initial() =>
      const ProductState(productStatus: ProductStatus.initial);
  ProductState copyWith({
    ProductStatus? productStatus,
    List<Product>? products,
    String? errorMessage,
    List<Product>? flashSaleProducts,
    int? currentIndex,
    String? selectedCondition,
    String? selectedWarranty,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
      flashSaleProducts: flashSaleProducts ?? this.flashSaleProducts,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedCondition: selectedCondition ?? this.selectedCondition,
      selectedWarranty: selectedWarranty ?? this.selectedWarranty,
    );
  }
}
