import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState {
  final CartStatus status;
  final List<CartItem> cartitems;
  final String? error;
  final int quantity;
  CartState({
    this.status = CartStatus.initial,
    this.cartitems = const [],
    this.error,
    this.quantity = 1,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartitem,
    String? error,
    int? quantity,
  }) {
    return CartState(
      status: status ?? this.status,
      cartitems: cartitem ?? this.cartitems,
      error: error ?? this.error,
      quantity: quantity ?? this.quantity,
    );
  }
}
