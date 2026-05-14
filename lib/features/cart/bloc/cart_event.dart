abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String productid;
  final String storename;
  final double price;
  final String imageUrl;
  final String rating;
  final String noOfRating;
  final String modelNumber;
  final String title;
  final String color;
  final String storage;
  AddToCartEvent({
    required this.productid,
    required this.storename,
    required this.price,
    this.imageUrl = "",
    this.rating = "",
    this.noOfRating = "",
    this.modelNumber = "",
    this.title = "",
    this.color = "",
    this.storage = "",
  });
}

class RemoveCartItemEvent extends CartEvent {
  final String cartitemid;
  RemoveCartItemEvent({required this.cartitemid});
}

class ClearCartErrorEvent extends CartEvent {}

class UpdateCartItemEvent extends CartEvent {
  final String cartItemid;
  final int currentQty;
  UpdateCartItemEvent({required this.cartItemid, required this.currentQty});
}

class GetCartItemsEvent extends CartEvent {}

class ClearCartEvent extends CartEvent {}

class ApplyWalletEvent extends CartEvent {
  final double walletAmount;
  ApplyWalletEvent(this.walletAmount);
}

class CartItemUpdateFailedEvent extends CartEvent {
  final String error;
  final List<dynamic> originalItems;
  CartItemUpdateFailedEvent({required this.error, required this.originalItems});
}

class CartItemRemoveFailedEvent extends CartEvent {
  final String error;
  final List<dynamic> originalItems;
  CartItemRemoveFailedEvent({required this.error, required this.originalItems});
}
