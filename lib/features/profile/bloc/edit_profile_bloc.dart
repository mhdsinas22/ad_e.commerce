import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aerstore/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:aerstore/features/profile/bloc/edit_profile_event.dart';
import 'package:aerstore/features/profile/bloc/edit_profile_state.dart';
import 'package:aerstore/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:aerstore/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:aerstore/features/profile/domain/usecases/upload_image_usecase.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UploadProfileImageUseCase uploadProfileImageUseCase;

  EditProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.uploadProfileImageUseCase,
  }) : super(const EditProfileState()) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<PickImageEvent>(_onPickImage);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onFetchProfile(
    FetchProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(status: EditProfileStatus.loading));

    final result = await getProfileUseCase(event.userId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (user) =>
          emit(state.copyWith(status: EditProfileStatus.success, user: user)),
    );
  }

  void _onPickImage(PickImageEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(selectedImage: event.image));
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(status: EditProfileStatus.loading, isSubmitting: true));

    String imageUrl = event.updatedUser.imageUrl;

    // upload image if selected
    if (state.selectedImage != null) {
      final uploadResult = await uploadProfileImageUseCase(
        state.selectedImage!,
        event.updatedUser.userId,
      );

      final uploadError = uploadResult.fold((l) => l, (r) => null);
      if (uploadError != null) {
        emit(
          state.copyWith(
            status: EditProfileStatus.failure,
            errorMessage: uploadError.message,
            isSubmitting: false,
          ),
        );
        return;
      }
      imageUrl = uploadResult.getRight().getOrElse(() => imageUrl);
    }

    final updatedUser = _createNewUserEntity(event.updatedUser, imageUrl);

    final updateResult = await updateProfileUseCase(updatedUser);

    updateResult.fold(
      (failure) => emit(
        state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: failure.message,
          isSubmitting: false,
        ),
      ),
      (user) => emit(
        state.copyWith(
          status: EditProfileStatus.success,
          user: user,
          isSubmitting: false,
          selectedImage: null,
        ),
      ), // clear selected image on success
    );
  }

  UserEntity _createNewUserEntity(UserEntity user, String imageUrl) {
    return UserEntity(
      userId: user.userId,
      email: user.email,
      username: user.username,
      phone: user.phone,
      imageUrl: imageUrl,
    );
  }
}
