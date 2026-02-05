class OrderItem {
  final String? id;
  final String orderId;
  final String productId;
  final String productName;
  final String productImage;
  final String productStorge;
  final String productColor;
  final String productModelNumber;
  final String productrating;
  final String productNoOfRating;
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
    required this.productStorge,
    required this.productColor,
    required this.productModelNumber,
    required this.productrating,
    required this.productNoOfRating,
  });
}
