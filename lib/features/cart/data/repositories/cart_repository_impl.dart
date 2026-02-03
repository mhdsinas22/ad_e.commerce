import 'package:ad_e_commerce/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';
import 'package:ad_e_commerce/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remote;
  CartRepositoryImpl(this.remote);
  @override
  Future<void> addCartItem({
    required String productid,
    required String storename,
    required double price,
  }) {
    return remote.addToCart(
      productId: productid,
      storeName: storename,
      price: price,
    );
  }

  @override
  Future<void> updateCartitem({
    required String cartitemid,
    required int quantity,
  }) {
    return remote.updateQuantity(cartItemId: cartitemid, quantity: quantity);
  }

  @override
  Future<List<CartItem>> getCartItems() {
    return remote.getCartItems();
  }

  @override
  Future<void> removCartitem({required String cartitemid}) {
    return remote.removeCartitem(cartitemid: cartitemid);
  }

  @override
  Future<void> clearCart() {
    return remote.clearCart();
  }
}
