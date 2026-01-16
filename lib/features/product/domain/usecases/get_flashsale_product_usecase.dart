import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/product/domain/repositories/product_repository.dart';

class GetFlashsaleProductUsecase {
  final ProductRepository repository;
  GetFlashsaleProductUsecase(this.repository);
  Future<List<Product>> call() async {
    return await repository.getFlashSaleProducts();
  }
}
