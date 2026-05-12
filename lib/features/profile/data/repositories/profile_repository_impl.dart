import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:aerstore/core/error/failures.dart';
import 'package:aerstore/data/models/user_model.dart';
import 'package:aerstore/domain/entities/user_entity.dart';
import 'package:aerstore/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:aerstore/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> getProfile(String userId) async {
    try {
      final user = await remoteDataSource.getProfile(userId);
      return right(user);
    } on ServerFailure catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(
    UserEntity userEntity,
  ) async {
    try {
      // Manual mapping is safe here as UserModel extends UserEntity
      // but creating a new UserModel ensures type safety for the DataSource
      final userModel = UserModel(
        userId: userEntity.userId,
        email: userEntity.email,
        username: userEntity.username,
        phone: userEntity.phone,
        imageUrl: userEntity.imageUrl,
      );

      final updatedUser = await remoteDataSource.updateProfile(userModel);
      return right(updatedUser);
    } on ServerFailure catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfileImage(
    File imageFile,
    String userId,
  ) async {
    try {
      final imageUrl = await remoteDataSource.uploadProfileImage(
        imageFile,
        userId,
      );
      return right(imageUrl);
    } on ServerFailure catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
