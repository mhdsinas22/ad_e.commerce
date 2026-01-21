import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';

abstract class CartRepository {
  Future<void> addCartItem({
    required String productid,
    required String storename,
    required double price,
  });
  Future<void> removCartitem({required String cartitemid});
  Future<void> updateCartitem({
    required String cartitemid,
    required int quantity,
  });
  Future<List<CartItem>> getCartItems();
}
