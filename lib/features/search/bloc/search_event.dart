abstract class SearchEvent {}

class SerachTextChanged extends SearchEvent {
  final String query;
  SerachTextChanged({required this.query});
}

class ClearSearch extends SearchEvent {}
