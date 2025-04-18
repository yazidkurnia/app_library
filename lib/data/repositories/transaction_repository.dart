import 'package:app_library/core/constants/debug_log.dart';
import 'package:app_library/domain/repositories/transaction_repository_interface.dart';

import '../../core/errors/server_failure.dart';
import '../../domain/entities/transaction_entity.dart';
import '../data_sources/remote_data_source/rds_transaction.dart';
import '../models/transaction/transaction_model.dart';

class TransactionRepository implements TransactionRepositoryInterface {
  final RdsTransaction rdsTransaction;

  TransactionRepository(this.rdsTransaction);

  @override
  Future<bool> storeTransaction(List<String> data) async {
    final response = await rdsTransaction.storeTransaction(data);

    DebugLog()
        .printLog('transaction store response: ${response['meta']}', 'info');
    if (response['meta']['code'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<TransactionEntity>> getAllTransaction() async {
    try {
      final response = await rdsTransaction.getTransactionState();
      DebugLog().printLog(
          'Transaction repository [getAllTransaction]: $response', 'info');

      DebugLog().printLog(response['data'], 'info');

      if (response['meta']['code'] == 200) {
        final List<dynamic>? statusTransaction =
            response['data']; // Menggunakan nullable type
        DebugLog().printLog(response['meta']['code'], 'info');

        // Memastikan statusTransaction tidak null dan merupakan List
        if (statusTransaction != null && statusTransaction is List) {
          List<TransactionEntity> transactions = [];

          for (var item in statusTransaction) {
            try {
              // Memastikan item tidak null dan memiliki data yang valid
              if (item != null) {
                transactions
                    .add(TransactionModel.fromJson(item).transactionEntity());
              } else {
                DebugLog().printLog('Item is null', 'warning');
              }
            } catch (e) {
              DebugLog().printLog('Error parsing item: $e', 'error');
            }
          }

          DebugLog().printLog(transactions, 'info');
          return transactions;
        } else {
          throw ServerFailure('Data transaksi tidak tersedia');
        }
      } else {
        var message = response['meta']['message'];
        String errorMessage;

        if (message is String) {
          errorMessage = message;
        } else if (message is Map) {
          errorMessage = message.toString();
        } else {
          errorMessage = 'An error occurred during sign in';
        }
        throw ServerFailure(errorMessage);
      }
    } catch (e) {
      DebugLog().printLog('Error: $e', 'error'); // Tambahkan log di sini
      throw Exception(e);
    }
  }

  @override
  Future<TransactionEntity> getTransactionById(String transactionId) async {
    try {
      final response = await rdsTransaction.getTransactionDetail(transactionId);
      DebugLog().printLog(
          'Transaction repository [getTransactionDetail]: $response', 'info');
      if (response['meta']['code'] == 200) {
        final dynamic detailTransaction = response['data'];
        //* lakukan pemeriksaan data
        return TransactionModel.fromJson(detailTransaction).transactionEntity();
      } else {
        var message = response['meta']['message'];
        String errorMessage;

        if (message is String) {
          errorMessage = message;
        } else if (message is Map) {
          errorMessage = message.toString();
        } else {
          errorMessage = 'Something wrong can not fetch data';
        }

        throw ServerFailure(errorMessage);
      }
    } catch (e) {
      DebugLog().printLog('Error: $e', 'error');
      throw Exception(e);
    }
  }
}
