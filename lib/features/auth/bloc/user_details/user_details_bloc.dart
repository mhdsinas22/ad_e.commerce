import 'package:ad_e_commerce/data/models/user_model.dart';
import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:ad_e_commerce/data/repositories/user_repository.dart';
import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  UserDetailsBloc({
    required String phone,
    required UserRepository userRepositoryy,
    required AuthRepository authRepository,
  }) : userRepository = userRepositoryy,
       // ignore: prefer_initializing_formals
       authRepository = authRepository,
       super(UserDetailsState(phone: phone)) {
    on<UsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<PhoneNumberChanged>((event, emit) {
      emit(state.copyWith(phoneNumber: event.phonenumber));
    });
    on<SubmitUserDetails>(_onSubmit);
  }
  Future<void> _onSubmit(
    SubmitUserDetails event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(state.copyWith(status: UserDetailsStatus.loading));

    try {
      final authResponse = await authRepository.signupwithEmail(
        email: state.email,
        password: state.password,
      );

      final user = authResponse.user;
      if (user == null) {
        throw Exception("Signup failed");
      }

      final userModel = UserModel(
        phone: state.phone,
        email: state.email,
        username: state.username,
        userId: user.id,
      );

      await userRepository.createUser(userModel);

      emit(state.copyWith(status: UserDetailsStatus.success));
    } on AuthApiException catch (e) {
      /// 🔐 SUPABASE AUTH ERRORS
      String message;

      if (e.code == 'user_already_exists') {
        message = "This email is already registered. Please login.";
      } else if (e.code == 'validation_failed') {
        message = "Please enter a strong password.";
      } else {
        message = e.message;
      }

      emit(state.copyWith(status: UserDetailsStatus.failure, error: message));
    } catch (e) {
      emit(
        state.copyWith(
          status: UserDetailsStatus.failure,
          error: "Something went wrong. Please try again.:-${e.toString()}",
        ),
      );
    }
  }
}
