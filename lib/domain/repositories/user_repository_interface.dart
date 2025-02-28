// lib/domain/repositories/user_repository_interface.dart

import '../entities/user_entity.dart';

abstract class UserRepositoryInterface {
  Future<UserEntity> signIn(String email, String password);

  Future<bool> signUp(String email, String password);
}
