import 'package:ad_e_commerce/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUsecase {
  final CartRepository cartRepository;
  AddToCartUsecase(this.cartRepository);
  Future<void> call({
    required String productid,
    required String storename,
    required double price,
  }) {
    return cartRepository.addCartItem(
      productid: productid,
      storename: storename,
      price: price,
    );
  }
}
