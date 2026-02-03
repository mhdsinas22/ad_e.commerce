import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';

abstract class CartRemoteDataSource {
  Future<void> addToCart({
    required String productId,
    required String storeName,
    required double price,
  });

  Future<void> updateQuantity({
    required String cartItemId,
    required int quantity,
  });

  Future<List<CartItem>> getCartItems();
  Future<void> removeCartitem({required String cartitemid});
  Future<void> clearCart();
}
