import 'package:aerstore/core/error/failures.dart';
import 'package:aerstore/domain/entities/user_entity.dart';
import 'package:aerstore/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String userId) {
    return repository.getProfile(userId);
  }
}
