import 'package:aerstore/features/product/domain/entites/product.dart';
import 'package:aerstore/features/home/domain/repositories/product_repository.dart';

class GetFlashsaleProductUsecase {
  final ProductRepository repository;
  GetFlashsaleProductUsecase(this.repository);
  Future<List<Product>> call() async {
    return await repository.getFlashSaleProducts();
  }
}
