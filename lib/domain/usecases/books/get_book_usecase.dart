import 'package:app_library/core/errors/server_failure.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/app_constant.dart';
import '../../../core/constants/debug_log.dart';
import '../../../core/errors/network_failure.dart';
import '../../entities/book_entity.dart';
import '../../repositories/book_repository_interface.dart';

class GetBookUseCase {
  final BookRepositoryInterface repository;

  GetBookUseCase(this.repository);

  Future<List<BookEntity>> getTopFiveBooks() async {
    try {
      return await repository.getTopFiveBook();
    } on DioException catch (e) {
      DebugLog().printLog('$e', 'error');
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
            errorMessage = 'Terjadi kesalahan pada request client.';
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
      DebugLog().printLog('Error: $e', 'error');
      throw ServerFailure('An unexpected error occurred');
    }
  }

  Future<List<BookEntity>> getAllBook() async {
    try {
      return await repository.getAllBook();
    } on DioException catch (e) {
      DebugLog().printLog('$e', 'error');

      if (e.response != null) {
        final statusCode = e.response!.statusCode;

        // get error message from response if available
        String errorMessage;
        if (e.response!.data != null &&
            e.response!.data['meta'] != null &&
            e.response!.data['meta']['message'] != null) {
          var message = e.response!.data['meta']['message'];
          errorMessage = message is String ? message : message.toString();
        } else {
          // Default error messages based on status code
          if (statusCode == 400) {
            errorMessage = 'Terjadi kesalahan pada request client';
          } else if (statusCode == 401) {
            errorMessage = 'Unauthorized access. please relogin';
          } else if (statusCode == 404) {
            errorMessage = 'Akun pengguna tidak ditemukan';
          } else {
            errorMessage = 'Server error: ${e.response!.statusCode}';
          }
        }
        DebugLog().printLog('Error response: ${e.response!.data}', 'error');
        throw ServerFailure(errorMessage);
      } else {
        DebugLog().printLog('Error response: ${e.response!.data}', 'error');
        throw NetworkFailure('Terjadi kesalahan pada jaringan');
      }
    } catch (e) {
      throw ServerFailure('An expected error occured');
    }
  }
}
