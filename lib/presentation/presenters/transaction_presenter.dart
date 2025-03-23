import 'package:app_library/core/constants/debug_log.dart';
import 'package:app_library/presentation/states/transactions/transaction_state.dart';

import '../../core/errors/failure.dart';
import '../../domain/usecases/transactions/post_transaction_usecase.dart';

class TransactionPresenter {
  final PostTransactionUseCase post;

  TransactionPresenter(this.post);

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
}
