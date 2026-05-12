import 'dart:io';
import 'package:aerstore/core/error/failures.dart';
import 'package:aerstore/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadProfileImageUseCase {
  final ProfileRepository repository;

  UploadProfileImageUseCase(this.repository);

  Future<Either<Failure, String>> call(File imageFile, String userId) {
    return repository.uploadProfileImage(imageFile, userId);
  }
}
