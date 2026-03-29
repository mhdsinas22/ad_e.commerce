import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:ad_e_commerce/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:ad_e_commerce/features/cart/data/models/local_cart_item_model.dart';
import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';
import 'package:ad_e_commerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remote;
  final CartLocalDatasource cartLocalDatasource;
  CartRepositoryImpl(this.remote, this.cartLocalDatasource);

  @override
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
  }) {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      return cartLocalDatasource.addToCart(
        LocalCartItemModel(
          productId: productid,
          price: price,
          quantity: 1,
          storename: storename,
          title: title,
          modelNumber: modelNumber,
          imageUrl: imageUrl,
          storeage: storage,
          color: color,
          rating: rating,
          noOfRating: noOfRating,
        ),
      );
    }
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
  }) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      return cartLocalDatasource.updateCart(cartitemid, quantity);
    }
    return remote.updateQuantity(cartItemId: cartitemid, quantity: quantity);
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      final items = await cartLocalDatasource.getCartItems();
      return items
          .map(
            (e) => CartItem(
              id: e.id,
              productId: e.productId,
              storename: e.storename,
              quantity: e.quantity,
              price: e.price,
              title: e.title,
              modelNumber: e.modelNumber,
              imageUrl: e.imageUrl,
              storeage: e.storeage,
              color: e.color,
              rating: e.rating,
              noOfRating: e.noOfRating,
            ),
          )
          .toList();
    } else {
      return remote.getCartItems();
    }
  }

  @override
  Future<void> removCartitem({required String cartitemid}) {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      return cartLocalDatasource.removeCartItem(cartitemid);
    }

    return remote.removeCartitem(cartitemid: cartitemid);
  }

  @override
  Future<void> clearCart() {
    return remote.clearCart();
  }

  @override
  Future<int> getTotalStocks({required String productId}) {
    return remote.getTotalStocks(productId: productId);
  }

  @override
  Future<void> syncGuestCart() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;
      final hiveitems = await cartLocalDatasource.getCartItems();
      for (var item in hiveitems) {
        await remote.addToCart(
          productId: item.productId,
          storeName: item.storename,
          price: item.price,
        );
        await cartLocalDatasource.clearCart();
      }
    } catch (e) {
      AppLogger.error("Sync GuestCart Error:-${e.toString()}");
    }
  }
}
