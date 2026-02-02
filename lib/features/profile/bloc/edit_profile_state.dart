import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:ad_e_commerce/domain/entities/user_entity.dart';

enum EditProfileStatus { initial, loading, success, failure }

class EditProfileState extends Equatable {
  final EditProfileStatus status;
  final UserEntity? user;
  final File? selectedImage;
  final String? errorMessage;
  final bool isSubmitting;

  const EditProfileState({
    this.status = EditProfileStatus.initial,
    this.user,
    this.selectedImage,
    this.errorMessage,
    this.isSubmitting = false,
  });

  EditProfileState copyWith({
    EditProfileStatus? status,
    UserEntity? user,
    File? selectedImage,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      selectedImage: selectedImage ?? this.selectedImage,
      errorMessage: errorMessage ?? this.errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
    status,
    user,
    selectedImage,
    errorMessage,
    isSubmitting,
  ];
}
