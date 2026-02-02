import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:ad_e_commerce/core/error/failures.dart';
import 'package:ad_e_commerce/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> getProfile(String userId);
  Future<Either<Failure, UserEntity>> updateProfile(UserEntity user);
  Future<Either<Failure, String>> uploadProfileImage(
    File imageFile,
    String userId,
  );
}
