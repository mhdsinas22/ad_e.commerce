import 'package:ad_e_commerce/features/product/domain/entites/product.dart';

enum SearchStatus { initial, loading, loaded, error }

class SearchState {
  final SearchStatus status;
  final List<Product> product;
  final String error;
  SearchState({
    this.error = "",
    this.product = const [],
    this.status = SearchStatus.initial,
  });
  SearchState copyWith({
    SearchStatus? status,
    List<Product>? product,
    String? error,
  }) {
    return SearchState(
      status: status ?? this.status,
      error: error ?? this.error,
      product: product ?? this.product,
    );
  }
}
