import 'package:ad_e_commerce/core/error/failures.dart';
import 'package:ad_e_commerce/domain/entities/user_entity.dart';
import 'package:ad_e_commerce/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(UserEntity user) {
    return repository.updateProfile(user);
  }
}
