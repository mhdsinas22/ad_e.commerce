class CartItemModel {
  final String id;
  final String title;
  final String model;
  final double price;
  final double rating;
  final int reviewCount;
  final int quantity;
  final String? imageUrl; // Using null for now, or placeholder

  const CartItemModel({
    required this.id,
    required this.title,
    required this.model,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.quantity,
    this.imageUrl,
  });
}

class CartDummyData {
  static const List<CartItemModel> items = [
    CartItemModel(
      id: '1',
      title: 'iPhone 13 (128GB) - Midnight',
      model: 'Model: A2633',
      price: 42999,
      rating: 4.9,
      reviewCount: 85,
      quantity: 2,
    ),
    CartItemModel(
      id: '2',
      title: 'iPhone 13 (128GB) - Midnight',
      model: 'Model: A2633',
      price: 42999,
      rating: 4.9,
      reviewCount: 85,
      quantity: 2,
    ),
  ];
}
