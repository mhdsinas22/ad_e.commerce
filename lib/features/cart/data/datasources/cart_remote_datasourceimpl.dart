import 'package:ad_e_commerce/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:ad_e_commerce/features/cart/data/models/cart_item_model.dart';
import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';
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
      print("AddToCart error: $e");
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
      print("updateCartErrod:-${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final cart =
          await supabase
              .from("carts")
              .select("id")
              .eq("user_id", userId)
              .eq("is_active", true)
              .maybeSingle();

      if (cart == null) return [];
      final response = await supabase
          .from("cart_items")
          .select(
            ''' id,product_id,store_name,quantity,price,products(id,title,model_number,image_url,color,storage)''',
          )
          .eq("cart_id", cart["id"]);
      print("AUTH USER ID: $userId");
      print("CART ROW: $cart");
      print("CART + PRODUCT DATA:$response");

      print(
        "response:- ${response.map((e) => CartItemModel.fromJson(e)).toList()}",
      );
      return response.map((e) => CartItemModel.fromJson(e)).toList();
    } catch (e) {
      print("GetCArtItems:-${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> removeCartitem({required String cartitemid}) async {
    try {
      await supabase.from("cart_items").delete().eq("id", cartitemid);
    } catch (e) {
      print("RemoveCartItems:-${e.toString()}");
      rethrow;
    }
  }

  Future<String> _getOrCreateCartId(String userId) async {
    final existing =
        await supabase
            .from('carts')
            .select('id')
            .eq('user_id', userId)
            .eq('is_active', true)
            .maybeSingle();

    if (existing != null) {
      return existing['id'];
    }

    final newCart =
        await supabase
            .from('carts')
            .insert({'user_id': userId})
            .select('id')
            .single();

    return newCart['id'];
  }

  @override
  Future<void> clearCart() async {
    final userId = supabase.auth.currentUser!.id;

    // 1️⃣ get active cart
    final cart =
        await supabase
            .from('carts')
            .select('id')
            .eq('user_id', userId)
            .eq('is_active', true)
            .maybeSingle();

    if (cart == null) return;

    final cartId = cart['id'];

    // 2️⃣ delete all cart_items
    await supabase.from('cart_items').delete().eq('cart_id', cartId);

    // 3️⃣ deactivate cart
    await supabase.from('carts').update({'is_active': false}).eq('id', cartId);
  }
}
