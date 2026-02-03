class OrderItem {
  final String? id;
  final String orderId;
  final String productId;
  final String productName;
  final String productImage;
  final String sku;
  final double price;
  final int quantity;
  OrderItem({
    this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.sku,
    required this.price,
    required this.quantity,
  });
}
