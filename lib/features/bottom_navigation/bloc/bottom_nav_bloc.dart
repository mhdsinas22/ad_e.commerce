import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_event.dart';
import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavState()) {
    on<BottomNavChanged>(_onBottomNavChanged);
  }
  Future<void> _onBottomNavChanged(
    BottomNavChanged event,
    Emitter<BottomNavState> emit,
  ) async {
    emit(state.copyWith(selectedIndex: event.index));
  }
}
