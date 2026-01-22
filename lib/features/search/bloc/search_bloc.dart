import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/search/bloc/search_event.dart';
import 'package:ad_e_commerce/features/search/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<Product> products;
  SearchBloc({required this.products})
    : super(SearchState(status: SearchStatus.initial)) {
    on<SerachTextChanged>(_onSearchTextChanged);

    on<ClearSearch>(_onClearSearch);
  }
  void _onSearchTextChanged(
    SerachTextChanged event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(status: SearchStatus.loading));

    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(status: SearchStatus.initial, product: []));
      return;
    }

    final results =
        products.where((product) {
          return product.title.toLowerCase().contains(query);
        }).toList();

    if (results.isEmpty) {
      emit(state.copyWith(status: SearchStatus.initial, product: []));
    } else {
      emit(
        state.copyWith(
          status: SearchStatus.loaded, // 🔥 FIX
          product: results,
        ),
      );
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: SearchStatus.initial, product: []));
  }
}
