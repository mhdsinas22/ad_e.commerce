import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState {
  final CartStatus status;
  final List<CartItem> cartitems;
  final String? error;
  final double subTotal;
  final double totalAmount;
  final double voucherAmount;
  final double deliveryFee;
  final bool isAdding;
  final String? loadingProductid;
  final double walletBalance; // user wallet balance
  final double walletUsed; // user entered wallet amount

  CartState({
    this.status = CartStatus.initial,
    this.cartitems = const [],
    this.error,
    this.subTotal = 0.0,
    this.totalAmount = 0.0,
    this.voucherAmount = 0.0,
    this.deliveryFee = 0.0,
    this.isAdding = false,
    this.loadingProductid,
    this.walletBalance = 0.0,
    this.walletUsed = 0.0,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartitems,
    String? error,
    double? subTotal,
    double? totalAmount,
    double? voucherAmount,
    double? deliveryFee,
    bool? isAdding,
    String? loadingProductid,
    bool clearLoadingProductId = false,
    double? walletBalance, // user wallet balance
    double? walletUsed, // user entered wallet amount
  }) {
    return CartState(
      status: status ?? this.status,
      cartitems: cartitems ?? this.cartitems,
      error: error ?? this.error,
      subTotal: subTotal ?? this.subTotal,
      totalAmount: totalAmount ?? this.totalAmount,
      voucherAmount: voucherAmount ?? this.voucherAmount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      isAdding: isAdding ?? this.isAdding,
      loadingProductid:
          clearLoadingProductId
              ? ""
              : loadingProductid ?? this.loadingProductid,
      walletBalance: walletBalance ?? this.walletBalance,
      walletUsed: walletUsed ?? this.walletUsed,
    );
  }
}
