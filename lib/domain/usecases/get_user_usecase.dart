import 'package:app_library/core/errors/network_failure.dart';
import 'package:dio/dio.dart';

import '../../core/constants/debug_log.dart';
import '../../core/errors/server_failure.dart';
import '../repositories/user_repository_interface.dart';

class GetUserUseCase {
  final UserRepositoryInterface repository;

  GetUserUseCase(this.repository);

  Future call(String email, String password) async {
    try {
      return await repository.signIn(email, password);
    } on DioException catch (e) {
      // Handle specific HTTP error codes
      if (e.response != null) {
        final statusCode = e.response!.statusCode;

        // Get error message from response if available
        String errorMessage;
        if (e.response!.data != null &&
            e.response!.data['meta'] != null &&
            e.response!.data['meta']['message'] != null) {
          var message = e.response!.data['meta']['message'];
          errorMessage = message is String ? message : message.toString();
        } else {
          // Default error messages based on status code
          if (statusCode == 400) {
            errorMessage =
                'Invalid email or password. Please check your credentials.';
          } else if (statusCode == 401) {
            errorMessage = 'Unauthorized access. Please log in again.';
          } else if (statusCode == 404) {
            errorMessage =
                'User not found. The email you entered does not exist.';
          } else {
            errorMessage = 'Server error: ${e.response!.statusCode}';
          }
        }

        DebugLog().printLog('Error response: ${e.response!.data}', 'error');
        throw ServerFailure(errorMessage);
      } else {
        // Network errors without response
        DebugLog().printLog('Network error: ${e.message}', 'error');
        throw NetworkFailure(
            'Network error. Please check your internet connection.');
      }
    } catch (e) {
      // Handle any other exceptions
      DebugLog().printLog('Unexpected error: $e', 'error');
      throw ServerFailure(
          'An unexpected error occurred. Please try again later.');
    }
  }

  Future<bool> signUp(String email, String password) async {
    return await repository.signUp(email, password);
  }
}
