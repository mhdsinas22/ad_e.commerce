import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/data/models/user_model.dart';
import 'package:aerstore/data/repositories/auth_repository.dart';
import 'package:aerstore/data/repositories/user_repository.dart';
import 'package:aerstore/features/auth/bloc/user_details/user_details_event.dart';
import 'package:aerstore/features/auth/bloc/user_details/user_details_state.dart';
import 'package:aerstore/features/profile/domain/repositories/wallet_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final WalletRepo walletRepo;
  UserDetailsBloc({
    required String phone,
    required UserRepository userRepositoryy,
    required AuthRepository authRepository,
    required this.walletRepo,
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
    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });
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
        imageUrl: event.imageUrl,
      );
      // 1 Create user Profile
      await userRepository.createUser(userModel);
      // 2  Create wallet + REWARD POINTS
      await walletRepo.createWallet(user.id);
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
      AppLogger.error("User Details Bloc Error:-${e.toString()}");
      emit(
        state.copyWith(
          status: UserDetailsStatus.failure,
          error: "Something went wrong. Please try again.:-${e.toString()}",
        ),
      );
    }
  }
}
