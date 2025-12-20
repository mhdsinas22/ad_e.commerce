import 'package:ad_e_commerce/data/models/user_model.dart';
import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:ad_e_commerce/data/repositories/user_repository.dart';
import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    on<SubmitUserDetails>(_onSubmit);
  }
  Future<void> _onSubmit(
    SubmitUserDetails event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(state.copyWith(status: UserDetailsStatus.loading));
    try {
      //  Auth user id
      final userId = authRepository.currentUser?.id;
      if (userId == null) {
        throw Exception("User is not authenticated");
      }
      // Create UserModel
      final user = UserModel(
        phone: state.phone,
        email: state.email,
        username: state.username,
        userId: userId.toString(),
      );

      // Update email and password if needed
      await authRepository.updateEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      // Save user details to database
      await userRepository.createUser(user);

      // Refresh session to reflect changes
      await authRepository.reloadSession();

      emit(state.copyWith(status: UserDetailsStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: UserDetailsStatus.failure, error: e.toString()),
      );
    }
  }
}
