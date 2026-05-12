import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:aerstore/features/cart/data/models/cart_item_model.dart';
import 'package:aerstore/features/cart/domain/enities/cart_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartRemoteDatasourceimpl implements CartRemoteDataSource {
  final SupabaseClient supabase;
  CartRemoteDatasourceimpl(this.supabase);
  @override
  @override
  Future<void> addToCart({
    required String productId,
    required String storeName,
    required double price,
  }) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      final cartId = await _getOrCreateCartId(userId);

      await supabase.from("cart_items").insert({
        "cart_id": cartId, // ✅ MUST
        "product_id": productId,
        "store_name": storeName,
        "quantity": 1, // ✅ MUST
        "price": price,
      });
    } catch (e) {
      AppLogger.error("Add To Cart Error:-${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      await supabase
          .from("cart_items")
          .update({"quantity": quantity})
          .eq("id", cartItemId);
    } catch (e) {
      AppLogger.error("updateCartErrod:-${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    final userId = supabase.auth.currentUser!.id;
    AppLogger.info("USER ID: $userId");
    try {
      final cart =
          await supabase
              .from("carts")
              .select("id")
              .eq("user_id", userId)
              .eq("is_active", true)
              .limit(1)
              .maybeSingle();

      if (cart == null) return [];
      final response = await supabase
          .from("cart_items")
          .select(
            ''' id,product_id,store_name,quantity,price,products(id,title,model_number,image_url,color,storage,rating,no_of_reviews)''',
          )
          .eq("cart_id", cart["id"]);
      AppLogger.info("AUTH USER ID: $userId");
      AppLogger.info("CART ROW: $cart");
      AppLogger.info("CART + PRODUCT DATA:$response");

      AppLogger.info(
        "response:- ${response.map((e) => CartItemModel.fromJson(e)).toList()}",
      );
      return response.map((e) => CartItemModel.fromJson(e)).toList();
    } catch (e) {
      AppLogger.error("GetCArtItems:-${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> removeCartitem({required String cartitemid}) async {
    try {
      await supabase.from("cart_items").delete().eq("id", cartitemid);
    } catch (e) {
      AppLogger.error("RemoveCartItems:-${e.toString()}");
      rethrow;
    }
  }

  Future<String> _getOrCreateCartId(String userId) async {
    try {
      final existing =
          await supabase
              .from('carts')
              .select('id')
              .eq('user_id', userId)
              .eq('is_active', true)
              .limit(1)
              .maybeSingle();

      if (existing != null) {
        return existing['id'];
      }

      final newCart =
          await supabase
              .from('carts')
              .insert({
                'user_id': userId,
                'is_active': true, // 🔥 VERY IMPORTANT
              })
              .select('id')
              .limit(1)
              .maybeSingle();

      if (newCart == null) {
        AppLogger.error("newCart:-${newCart.toString()}");
        throw Exception("Cart not created. Check RLS policy.");
      }

      return newCart['id'];
    } catch (e) {
      AppLogger.error("GetOrCreateCartId:-${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> clearCart() async {
    final userId = supabase.auth.currentUser!.id;

    // 1️ get active cart
    final cart =
        await supabase
            .from('carts')
            .select('id')
            .eq('user_id', userId)
            .eq('is_active', true)
            .limit(1)
            .maybeSingle();

    if (cart == null) return;

    final cartId = cart['id'];

    // 2️ delete all cart_items
    await supabase.from('cart_items').delete().eq('cart_id', cartId);

    // 3 deactivate cart
    await supabase.from('carts').update({'is_active': false}).eq('id', cartId);
  }

  @override
  Future<int> getTotalStocks({required String productId}) async {
    try {
      final response = await supabase
          .from("product_stocks")
          .select("quantity")
          .eq("product_id", productId);
      int totalStock = 0;
      for (var item in response) {
        totalStock += (item["quantity"] as int);
      }
      return totalStock;
    } catch (e) {
      AppLogger.error("GetTotalStocks:-${e.toString()}");
      rethrow;
    }
  }
}
