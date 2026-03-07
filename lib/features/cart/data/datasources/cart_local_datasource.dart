import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/cart/data/models/local_cart_item_model.dart';
import 'package:hive/hive.dart';

class CartLocalDatasource {
  final box = Hive.box("guest_cart");
  Future<void> addToCart(LocalCartItemModel localCart) async {
    try {
      AppLogger.info("Hive Add to Cart Working");
      final items = box.values.toList();
      final index = items.indexWhere(
        (element) =>
            Map<String, dynamic>.from(element)["product_id"] ==
            localCart.productId,
      );
      if (index != -1) {
        final existingItem = Map<String, dynamic>.from(items[index]);
        existingItem["quantity"] += localCart.quantity;
        await box.putAt(index, existingItem);
      } else {
        final response = await box.add(localCart.toJson());
        AppLogger.info("Hive Cart Added Data:-$response");
      }
    } catch (e) {
      AppLogger.error("Hive Add to Cart Error:-${e.toString()}");
    }
  }

  Future<List<LocalCartItemModel>> getCartItems() async {
    try {
      final items = box.values.toList();
      AppLogger.info("Hive Cart Get Data:-$items");
      return items
          .map((e) => LocalCartItemModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      AppLogger.error("Hive Get Cart Error:-${e.toString()}");
      return [];
    }
  }

  Future<void> removeCartItem(String cartItemid) async {
    try {
      await box.delete(cartItemid);
    } catch (e) {
      AppLogger.error("Hive Delete Cart Error:-${e.toString()}");
    }
  }
}
