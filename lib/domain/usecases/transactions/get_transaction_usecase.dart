import 'package:app_library/core/constants/debug_log.dart';
import 'package:app_library/domain/repositories/transaction_repository_interface.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/network_failure.dart';
import '../../../core/errors/server_failure.dart';
import '../../entities/transaction_entity.dart';

class GetTransactionUseCase {
  final TransactionRepositoryInterface get_transa_repository;

  GetTransactionUseCase(this.get_transa_repository);

  Future<List<TransactionEntity>> getTransactionState() async {
    try {
      return await get_transa_repository.getAllTransaction();
    } on DioException catch (e) {
      DebugLog().printLog('Data transaction gagal didapatkan, $e', 'info');
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
      throw ServerFailure('An expected error occured: $e');
    }
  }

  // todo:: get detail transaction
  Future<TransactionEntity> getTransactionDetail(transactionId) async {
    try {
      return await get_transa_repository.getTransactionById(transactionId);
    } on DioException catch (e) {
      //! this is an error
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
      DebugLog().printLog(
          'GetTransactionUseCase [getTransactionDetail]: $e', 'error');
      throw ServerFailure('An expected error occured');
    }
  }
}
