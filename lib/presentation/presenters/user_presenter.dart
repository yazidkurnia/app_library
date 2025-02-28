// lib/presentation/presenters/user_presenter.dart

import '../../core/constants/app_constant.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../core/errors/failure.dart';

class UserPresenter {
  final GetUserUseCase getUserUseCase;

  UserPresenter(this.getUserUseCase);

  Future<UserEntity?> signIn(String email, String password) async {
    try {
      return await getUserUseCase.call(email, password);
    } catch (e) {
      if (e is Failure) {
        AppConstants().printLog('$e', 'error');
      }
      return null;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      return await getUserUseCase.signUp(email, password);
    } catch (e) {
      AppConstants().printLog(e.toString(), 'error');
      return false;
    }
  }
}
