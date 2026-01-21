import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_state.dart';
import 'package:ad_e_commerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:ad_e_commerce/features/cart/domain/usecases/add_to_cart_usecase.dart';
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
    emit(state.copyWith(status: CartStatus.loading));
    try {
      await addToCartUsecase.call(
        productid: event.productid,
        storename: event.storename,
        price: event.price,
      );
      final items = await cartRepository.getCartItems();
      emit(state.copyWith(status: CartStatus.loaded, cartitem: items));
    } catch (e) {
      print("erorr:_${e.toString()}");
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }

  Future<void> _removeCartItem(
    RemoveCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await cartRepository.removCartitem(cartitemid: event.cartitemid);
      final items = await cartRepository.getCartItems();
      emit(state.copyWith(cartitem: items));
    } catch (e) {
      print("Remove:_${e.toString()}");
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }

  Future<void> _updateCartItem(
    UpdateCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await cartRepository.updateCartitem(
        cartitemid: event.cartItemid,
        quantity: event.currentQty + 1,
      );
      final items = await cartRepository.getCartItems();
      emit(state.copyWith(cartitem: items));
    } catch (e) {
      print("udpate:_${e.toString()}");
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }

  Future<void> _getCartItem(
    GetCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      final items = await cartRepository.getCartItems();
      emit(state.copyWith(status: CartStatus.loaded, cartitem: items));
    } catch (e) {
      print("GetCartItems:_${e.toString()}");
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }
}
