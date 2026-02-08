import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_event.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_state.dart';
import 'package:ad_e_commerce/features/product/domain/usecases/get_flashsale_product_usecase.dart';
import 'package:ad_e_commerce/features/product/domain/usecases/get_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUsecase getProductUsecase;
  final GetFlashsaleProductUsecase getFlashsaleProductUsecase;
  ProductBloc(this.getProductUsecase, this.getFlashsaleProductUsecase)
    : super(ProductState.initial()) {
    on<LoadProductsEvent>(_loadProducts);
    on<LoadFlashSaleProductsEvent>(_loadFlashSaleProducts);
    on<UpdateConditionFilter>(_updateConditionFilter);
    on<UpdateWarrantyFilter>(_updateWarrantyFilter);
  }
  Future<void> _loadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    try {
      final products = await getProductUsecase.call();
      emit(
        state.copyWith(
          products: products,
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

  Future<void> _loadFlashSaleProducts(
    LoadFlashSaleProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    try {
      final flashProducts = await getFlashsaleProductUsecase.call();
      emit(
        state.copyWith(
          productStatus: ProductStatus.success,
          flashSaleProducts: flashProducts,
        ),
      );
    } catch (e) {
      state.copyWith(
        productStatus: ProductStatus.failure,
        errorMessage: "Unable to Load flashSale Products",
      );
    }
  }

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
}
