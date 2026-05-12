import 'package:aerstore/features/product/bloc/proudctbloc/product_event.dart';
import 'package:aerstore/features/product/bloc/proudctbloc/product_state.dart';
import 'package:aerstore/features/product/domain/entites/product.dart';
import 'package:aerstore/features/product/domain/usecases/get_flashsale_product_usecase.dart';
import 'package:aerstore/features/product/domain/usecases/get_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUsecase getProductUsecase;
  final GetFlashsaleProductUsecase getFlashsaleProductUsecase;
  ProductBloc(this.getProductUsecase, this.getFlashsaleProductUsecase)
    : super(ProductState.initial()) {
    on<LoadProductsEvent>(_loadProducts);
    // on<LoadFlashSaleProductsEvent>(_loadFlashSaleProducts);
    on<UpdateConditionFilter>(_updateConditionFilter);
    on<UpdateWarrantyFilter>(_updateWarrantyFilter);
    on<GetProductByIdEvent>(_getProductById);
    on<ResetProductFilters>((event, emit) {
      emit(
        state.copyWith(
          selectedCondition: "Select Condition",
          selectedWarranty: "Choose Warranty",
        ),
      );
    });
  }
  Future<void> _loadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    try {
      final products = await getProductUsecase.call();
      final flashSaleProducts =
          products.where((p) => p.tag == "Flash Sale").toList();
      emit(
        state.copyWith(
          products: products,
          flashSaleProducts: flashSaleProducts,
          productStatus: ProductStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productStatus: ProductStatus.failure,
          errorMessage: "Faild TO Load Products :-${e.toString()}",
        ),
      );
    }
  }

  // Future<void> _loadFlashSaleProducts(
  //   LoadFlashSaleProductsEvent event,
  //   Emitter<ProductState> emit,
  // ) async {
  //   emit(state.copyWith(productStatus: ProductStatus.loading));
  //   try {
  //     final products = await getProductUsecase.call();
  //     final flashSaleProducts =
  //         products.where((p) => p.tag == "Flash Sale").toList();
  //     emit(
  //       state.copyWith(
  //         productStatus: ProductStatus.success,
  //         flashSaleProducts: flashSaleProducts,
  //       ),
  //     );
  //   } catch (e) {
  //     state.copyWith(
  //       productStatus: ProductStatus.failure,
  //       errorMessage: "Unable to Load flashSale Products",
  //     );
  //   }
  // }

  Future<void> _updateConditionFilter(
    UpdateConditionFilter event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(selectedCondition: event.condition));
  }

  void _updateWarrantyFilter(
    UpdateWarrantyFilter event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(selectedWarranty: event.warranty));
  }

  Future<void> _getProductById(
    GetProductByIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    // 1. First loading state kaanikkanam
    emit(state.copyWith(productStatus: ProductStatus.loading));

    try {
      // 2. Database-il ninnu ella products-um edukkunnu
      final List<Product> allProducts = await getProductUsecase.call();

      // 3. Nammal anuppiya ID vechu product-ine find cheyyunnu
      final product = allProducts.firstWhere(
        (element) => element.id == event.productid,
      );

      // 4. State update cheyyunnu
      // Note: products: [product] ennu koduthaal baaki ella products-um remove aakum.
      // Deep link vazhi varumpol athu prashnamilla.
      emit(
        state.copyWith(
          products: [product],
          productStatus: ProductStatus.success,
        ),
      );
    } catch (e) {
      // 5. Product kandilla enkil error handle cheyyunnu
      emit(
        state.copyWith(
          productStatus: ProductStatus.failure,
          errorMessage: "Failed to load product details.",
        ),
      );
    }
  }
}
