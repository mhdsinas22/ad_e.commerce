import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';

import 'package:ad_e_commerce/features/search/bloc/search_event.dart';
import 'package:ad_e_commerce/features/search/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductBloc productBloc;

  SearchBloc({required this.productBloc})
    : super(SearchState(status: SearchStatus.initial)) {
    on<SerachTextChanged>(_onSearchTextChanged);
    on<ClearSearch>(_onClearSearch);
  }

  void _onSearchTextChanged(
    SerachTextChanged event,
    Emitter<SearchState> emit,
  ) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(
        state.copyWith(status: SearchStatus.initial, product: [], query: ""),
      );
      return;
    }

    emit(state.copyWith(status: SearchStatus.loading, query: query));

    final products = productBloc.state.products; // ✅ LIVE DATA

    final results =
        products.where((product) {
          final title = product.title.toLowerCase().replaceAll(" ", "");
          final category = product.category.toLowerCase().replaceAll(" ", "");
          final search = query.replaceAll(" ", "");

          return title.contains(search) || category.contains(search);
        }).toList();

    if (results.isEmpty) {
      emit(
        state.copyWith(status: SearchStatus.empty, product: [], query: query),
      );
    } else {
      emit(state.copyWith(status: SearchStatus.loaded, product: results));
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: SearchStatus.initial, product: []));
  }
}
