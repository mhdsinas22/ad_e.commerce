import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_state.dart';
import 'package:ad_e_commerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:ad_e_commerce/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUsecase addToCartUsecase;
  final CartRepository cartRepository;

  CartBloc(this.addToCartUsecase, this.cartRepository) : super(CartState()) {
    on<AddToCartEvent>(_addTocart);
    on<RemoveCartItemEvent>(_removeCartItem);
    on<UpdateCartItemEvent>(_updateCartItem);
    on<GetCartItemsEvent>(_getCartItem);
  }

  Future<void> _addTocart(AddToCartEvent event, Emitter<CartState> emit) async {
    // Optimistic or loading - standard is loading for add to cart usually,
    // but here we might want to just load.
    emit(state.copyWith(status: CartStatus.loading));
    try {
      await addToCartUsecase.call(
        productid: event.productid,
        storename: event.storename,
        price: event.price,
      );
      final items = await cartRepository.getCartItems();
      final totals = _calculateTotals(items);
      emit(
        state.copyWith(
          status: CartStatus.loaded,
          cartitem: items,
          subTotal: totals['subTotal'],
          voucherAmount: totals['voucherAmount'],
          deliveryFee: totals['deliveryFee'],
          totalAmount: totals['totalAmount'],
        ),
      );
    } catch (e) {
      print("erorr:_${e.toString()}");
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }

  Future<void> _removeCartItem(
    RemoveCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    // Optimistic Update
    final originalItems = state.cartitems;
    try {
      // 1. Update local state immediately
      final updatedItems =
          state.cartitems.where((item) => item.id != event.cartitemid).toList();
      final totals = _calculateTotals(updatedItems);
      emit(
        state.copyWith(
          cartitem: updatedItems,
          subTotal: totals['subTotal'],
          voucherAmount: totals['voucherAmount'],
          deliveryFee: totals['deliveryFee'],
          totalAmount: totals['totalAmount'],
        ),
      );

      // 2. Perform API call
      await cartRepository.removCartitem(cartitemid: event.cartitemid);

      // Optional: Re-fetch to accept server state, or trust local if success
      // final items = await cartRepository.getCartItems();
      // emit(state.copyWith(cartitem: items));
    } catch (e) {
      print("Remove:_${e.toString()}");
      // Revert on error
      final totals = _calculateTotals(originalItems);
      emit(
        state.copyWith(
          status: CartStatus.error,
          error: e.toString(),
          cartitem: originalItems,
          subTotal: totals['subTotal'],
          voucherAmount: totals['voucherAmount'],
          deliveryFee: totals['deliveryFee'],
          totalAmount: totals['totalAmount'],
        ),
      );
    }
  }

  Future<void> _updateCartItem(
    UpdateCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    // Optimistic Update
    final originalItems = List<CartItem>.from(state.cartitems);
    try {
      final index = state.cartitems.indexWhere(
        (item) => item.id == event.cartItemid,
      );
      if (index == -1) return;

      final currentItem = state.cartitems[index];
      // Logic: Ensure quantity is at least 1
      if (event.currentQty < 1) {
        // Optionally remove or just ignore.
        // User requirement: "Minimum quantity = 1 (do not allow 0)"
        return;
      }

      // Create updated item with NEW quantity (event.currentQty is the target)
      // NOTE: We do NOT use `currentItem.copywith` because CartItem handles immutability?
      // CartItem is a class. We need a way to clone it.
      // Checking CartItem definition... it does not have copyWith.
      // I need to use CartItemModel or create a new instance manually?
      // Or I can cast to CartItemModel if it is one. Usually it is.
      // But better to strictly use available constructors.

      final updatedItem = CartItem(
        id: currentItem.id,
        productId: currentItem.productId,
        storename: currentItem.storename,
        quantity: event.currentQty, // Update quantity
        price: currentItem.price,
        title: currentItem.title,
        modelNumber: currentItem.modelNumber,
        imageUrl: currentItem.imageUrl,
        storeage: currentItem.storeage,
        color: currentItem.color,
      );

      final updatedList = List<CartItem>.from(state.cartitems);
      updatedList[index] = updatedItem;

      final totals = _calculateTotals(updatedList);

      // Emit optimistic state
      emit(
        state.copyWith(
          cartitem: updatedList,
          subTotal: totals['subTotal'],
          voucherAmount: totals['voucherAmount'],
          deliveryFee: totals['deliveryFee'],
          totalAmount: totals['totalAmount'],
        ),
      );

      // Call API
      await cartRepository.updateCartitem(
        cartitemid: event.cartItemid,
        quantity: event.currentQty,
      );

      // We do NOT re-fetch the entire list to avoid flicker/loading.
    } catch (e) {
      print("udpate:_${e.toString()}");
      final totals = _calculateTotals(originalItems);
      emit(
        state.copyWith(
          status: CartStatus.error,
          error: e.toString(),
          cartitem: originalItems,
          subTotal: totals['subTotal'],
          voucherAmount: totals['voucherAmount'],
          deliveryFee: totals['deliveryFee'],
          totalAmount: totals['totalAmount'],
        ),
      );
    }
  }

  Future<void> _getCartItem(
    GetCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      final items = await cartRepository.getCartItems();
      final totals = _calculateTotals(items);
      emit(
        state.copyWith(
          status: CartStatus.loaded,
          cartitem: items,
          subTotal: totals['subTotal'],
          voucherAmount: totals['voucherAmount'],
          deliveryFee: totals['deliveryFee'],
          totalAmount: totals['totalAmount'],
        ),
      );
    } catch (e) {
      print("GetCartItems:_${e.toString()}");
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }

  // Constants for configuration (could be moved to a config file/remote config later)
  static const double kDeliveryFee = 20.0;
  static const double kVoucherAmount = 100.0;

  Map<String, double> _calculateTotals(List<CartItem> items) {
    double subTotal = 0;
    for (var item in items) {
      subTotal += (item.price * item.quantity);
    }

    // Voucher Logic: Apply voucher only if subtotal > 0 (or some threshold)
    double voucher = subTotal > 0 ? kVoucherAmount : 0;

    // Delivery Fee Logic: Apply only if cart is not empty
    double delivery = subTotal > 0 ? kDeliveryFee : 0;

    // Total Calculation
    double total = subTotal - voucher + delivery;

    // Ensure total is not negative
    if (total < 0) total = 0;

    return {
      'subTotal': subTotal,
      'voucherAmount': voucher,
      'deliveryFee': delivery,
      'totalAmount': total,
    };
  }
}
