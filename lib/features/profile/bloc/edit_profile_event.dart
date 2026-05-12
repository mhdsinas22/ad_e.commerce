import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:aerstore/domain/entities/user_entity.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchProfileEvent extends EditProfileEvent {
  final String userId;
  const FetchProfileEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class PickImageEvent extends EditProfileEvent {
  final File image;
  const PickImageEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class UpdateProfileEvent extends EditProfileEvent {
  final UserEntity updatedUser;
  const UpdateProfileEvent(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}
