abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String productid;
  final String storename;
  final double price;
  AddToCartEvent({
    required this.productid,
    required this.storename,
    required this.price,
  });
}

class RemoveCartItemEvent extends CartEvent {
  final String cartitemid;
  RemoveCartItemEvent({required this.cartitemid});
}

class UpdateCartItemEvent extends CartEvent {
  final String cartItemid;
  final int currentQty;
  UpdateCartItemEvent({required this.cartItemid, required this.currentQty});
}

class GetCartItemsEvent extends CartEvent {}
