import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState {
  final CartStatus status;
  final List<CartItem> cartitems;
  final String? error;
  final double subTotal;
  final double totalAmount;

  CartState({
    this.status = CartStatus.initial,
    this.cartitems = const [],
    this.error,
    this.subTotal = 0.0,
    this.totalAmount = 0.0,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartitem,
    String? error,
    double? subTotal,
    double? totalAmount,
  }) {
    return CartState(
      status: status ?? this.status,
      cartitems: cartitem ?? this.cartitems,
      error: error ?? this.error,
      subTotal: subTotal ?? this.subTotal,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
