abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {}

class RefreshProductsEvent extends ProductEvent {}

class LoadFlashSaleProductsEvent extends ProductEvent {}

class UpdateConditionFilter extends ProductEvent {
  final String condition; // "Brand New" | "Pre-Owned"

  UpdateConditionFilter(this.condition);
}

class UpdateWarrantyFilter extends ProductEvent {
  final String warranty;
  UpdateWarrantyFilter(this.warranty);
}

class ResetProductFilters extends ProductEvent {}

class GetProductByIdEvent extends ProductEvent {
  final String productid;
  GetProductByIdEvent({required this.productid});
}
