import 'package:app_library/core/constants/debug_log.dart';
import 'package:app_library/presentation/states/transactions/transaction_state.dart';

import '../../core/errors/failure.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/usecases/transactions/get_transaction_usecase.dart';
import '../../domain/usecases/transactions/post_transaction_usecase.dart';

class TransactionPresenter {
  final PostTransactionUseCase post;
  final GetTransactionUseCase get;

  TransactionPresenter(this.post, this.get);

  Future<bool> storeTransaction(List<String> data) async {
    TransactionState transactionState = TransactionState();
    try {
      transactionState.setLoading(true);
      bool status = await post.storeTransaction(data);
      transactionState.setLoading(false);
      DebugLog().printLog(
          'Transaction Presenter [storeTransaction]: $status', 'info');
      return status;
    } catch (e) {
      if (e is Failure) {
        DebugLog()
            .printLog('Transaction presenter [storeTransaction]: $e', 'error');
      }
      DebugLog()
          .printLog('Transaction presenter [storeTransaction]: $e', 'error');
      return false;
    }
  }

  Future<List<TransactionEntity?>> getTransactionState() async {
    try {
      return get.getTransactionState();
    } catch (e) {
      if (e is Failure) {
        DebugLog().printLog(e.message, 'error');
      }
      DebugLog().printLog('Terjadi kesalahan', 'error');
      return [];
    }
  }

  Future<TransactionEntity?> getTransactionDetail(transactionId) async {
    try {
      return get.getTransactionDetail(transactionId);
    } catch (e) {
      // if (e is Failure) {
      DebugLog()
          .printLog('TransactionPresenter [getTransactionDetail]', 'error');
      return null;
      // }
    }
  }
}
