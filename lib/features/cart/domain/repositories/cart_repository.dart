import 'package:aerstore/features/cart/domain/enities/cart_item.dart';

abstract class CartRepository {
  Future<void> addCartItem({
    required String productid,
    required String storename,
    required double price,
    String imageUrl = "",
    String color = "",
    String rating = "",
    String noOfRating = "",
    String modelNumber = "",
    String title = "",
    String storage = "",
  });
  Future<void> removCartitem({required String cartitemid});
  Future<void> updateCartitem({
    required String cartitemid,
    required int quantity,
  });
  Future<List<CartItem>> getCartItems();
  Future<void> clearCart();
  Future<int> getTotalStocks({required String productId});
  Future<void> syncGuestCart();
}
