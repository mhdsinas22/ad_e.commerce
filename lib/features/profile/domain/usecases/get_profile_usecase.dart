import 'package:ad_e_commerce/core/error/failures.dart';
import 'package:ad_e_commerce/domain/entities/user_entity.dart';
import 'package:ad_e_commerce/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String userId) {
    return repository.getProfile(userId);
  }
}
