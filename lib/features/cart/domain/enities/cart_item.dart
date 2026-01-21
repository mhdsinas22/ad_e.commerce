class CartItem {
  final String? id;
  final String productId;
  final String storename;
  final int quantity;
  final double price;
  // product details
  final String title;
  final String modelNumber;
  final String imageUrl;
  final String storeage;
  final String color;
  CartItem({
    this.id,
    required this.productId,
    required this.storename,
    required this.quantity,
    required this.price,
    required this.title,
    required this.modelNumber,
    required this.imageUrl,
    required this.storeage,
    required this.color,
  });
}
