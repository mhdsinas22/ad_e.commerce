import 'dart:io';
import 'package:ad_e_commerce/core/error/failures.dart';
import 'package:ad_e_commerce/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadProfileImageUseCase {
  final ProfileRepository repository;

  UploadProfileImageUseCase(this.repository);

  Future<Either<Failure, String>> call(File imageFile, String userId) {
    return repository.uploadProfileImage(imageFile, userId);
  }
}
