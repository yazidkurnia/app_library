// lib/data/repositories/user_repository.dart

import 'package:app_library/core/constants/app_constant.dart';

import '../../core/errors/server_failure.dart';
import '../../domain/repositories/user_repository_interface.dart';
import '../data_sources/localstorage/shared_preferences_service.dart';
import '../data_sources/remote_data_source.dart';
import '../models/user/user_model.dart';
import '../../domain/entities/user_entity.dart';

class UserRepository implements UserRepositoryInterface {
  final RemoteDataSource remoteDataSource;
  final SharedPreferencesService sharedPreferencesService;

  UserRepository(this.remoteDataSource, this.sharedPreferencesService);

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final response = await remoteDataSource.signIn(email, password);
    AppConstants().printLog('response api client: $response', 'info');
    if (response['meta']['code'] == 200) {
      final userModel = UserModel.fromJson(response['data']);
      await sharedPreferencesService.saveToken(userModel.token);
      return userModel.toEntity(); // Mengonversi UserModel ke UserEntity
    } else {
      // Handle the case where message might be a Map instead of a String
      var message = response['meta']['message'];
      String errorMessage;

      if (message is String) {
        errorMessage = message;
      } else if (message is Map) {
        // Convert the Map to a readable string or extract relevant information
        errorMessage = message.toString();
      } else {
        // Fallback error message
        errorMessage = 'An error occurred during sign in';
      }

      throw ServerFailure(errorMessage);
    }
  }

  @override
  Future<bool> signUp(String email, String password) async {
    final response = await remoteDataSource.signUp(email, password);
    AppConstants().printLog('repository response ${response['meta']}', 'info');
    if (response['meta']['code'] == 200) {
      // AppConstants().printLog(response, 'info');
      AppConstants().printLog(response, 'info');
      return true;
    } else {
      // print(response);
      AppConstants().printLog(response, 'error');
      return false;
    }
  }
}
