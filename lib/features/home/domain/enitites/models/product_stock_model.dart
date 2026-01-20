class ProductStockModel {
  final String productId;
  final String storeName;
  final int quantity;

  ProductStockModel({
    required this.productId,
    required this.storeName,
    required this.quantity,
  });

  factory ProductStockModel.fromMap(Map<String, dynamic> map) {
    return ProductStockModel(
      productId: map['product_id']?.toString() ?? '',
      storeName: map['store_name']?.toString() ?? '',
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'store_name': storeName,
      'quantity': quantity,
    };
  }
}
