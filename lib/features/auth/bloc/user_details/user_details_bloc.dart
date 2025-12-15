import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(const UserDetailsState()) {
    on<UserDetailsNameChanged>(_onNameChanged);
    on<UserDetailsEmailChanged>(_onEmailChanged);
    on<UserDetailsGenderChanged>(_onGenderChanged);
    on<UserDetailsSubmit>(_onSubmit);
  }

  void _onNameChanged(
    UserDetailsNameChanged event,
    Emitter<UserDetailsState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onEmailChanged(
    UserDetailsEmailChanged event,
    Emitter<UserDetailsState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onGenderChanged(
    UserDetailsGenderChanged event,
    Emitter<UserDetailsState> emit,
  ) {
    emit(state.copyWith(gender: event.gender));
  }

  Future<void> _onSubmit(
    UserDetailsSubmit event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(state.copyWith(status: UserDetailsStatus.saving));
    try {
      // TODO: Integrate actual UserRepository here
      await Future.delayed(const Duration(seconds: 2)); // Mock API delay

      if (state.name.isNotEmpty &&
          state.email.isNotEmpty &&
          state.gender != 'Select Gender') {
        emit(state.copyWith(status: UserDetailsStatus.saved));
      } else {
        emit(
          state.copyWith(
            status: UserDetailsStatus.failure,
            errorMessage: 'Please fill all fields',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: UserDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
