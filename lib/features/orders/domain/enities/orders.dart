class Orders {
  final String? id;
  final String userId;
  final double totalAmount;
  final String status;
  final String paymentMethod;
  final Map<String, dynamic> shippingAddress;

  Orders({
    this.id,
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.paymentMethod,
    required this.shippingAddress,
  });
}
