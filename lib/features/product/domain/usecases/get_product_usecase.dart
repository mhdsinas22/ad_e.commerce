import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/home/domain/repositories/product_repository.dart';

class GetProductUsecase {
  final ProductRepository repository;
  GetProductUsecase(this.repository);
  Future<List<Product>> call() async {
    return repository.getproducts();
  }
}
