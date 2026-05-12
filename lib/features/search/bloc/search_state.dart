import 'package:aerstore/features/product/domain/entites/product.dart';

enum SearchStatus { initial, loading, loaded, error, empty }

class SearchState {
  final SearchStatus status;
  final List<Product> product;
  final String error;
  final String query;
  SearchState({
    this.error = "",
    this.product = const [],
    this.status = SearchStatus.initial,
    this.query = "",
  });
  SearchState copyWith({
    SearchStatus? status,
    List<Product>? product,
    String? error,
    String? query,
  }) {
    return SearchState(
      status: status ?? this.status,
      error: error ?? this.error,
      product: product ?? this.product,
      query: query ?? this.query,
    );
  }
}
