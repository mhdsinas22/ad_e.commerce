class ProductStock {
  final String? id;
  final String productId;
  final String storeName;
  final int quantity;

  ProductStock({
    this.id,
    required this.productId,
    required this.storeName,
    required this.quantity,
  });
}
