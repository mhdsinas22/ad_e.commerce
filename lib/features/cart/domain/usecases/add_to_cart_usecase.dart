import 'package:aerstore/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUsecase {
  final CartRepository cartRepository;
  AddToCartUsecase(this.cartRepository);
  Future<void> call({
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
    return cartRepository.addCartItem(
      productid: productid,
      storename: storename,
      price: price,
      color: color,
      imageUrl: imageUrl,
      noOfRating: noOfRating,
      rating: rating,
      modelNumber: modelNumber,
      title: title,
      storage: storage,
    );
  }
}
