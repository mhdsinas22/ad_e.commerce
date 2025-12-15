import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      // TODO: Integrate actual AuthRepository here
      await Future.delayed(const Duration(seconds: 2)); // Mock API delay

      if (event.username == 'user' && event.password == 'password') {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: 'Invalid username or password',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
