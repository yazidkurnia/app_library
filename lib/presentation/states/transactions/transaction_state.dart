import 'package:app_library/core/constants/debug_log.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/transaction_entity.dart';
import '../../presenters/transaction_presenter.dart';

class TransactionState with ChangeNotifier {
  List<TransactionEntity>? _transactionState = [];
  TransactionEntity? _singleTransactionData;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<TransactionEntity> get transactionState => _transactionState!;
  TransactionEntity get singleTransactionData => _singleTransactionData!;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setAllTransaciton(List<TransactionEntity> transactionState) {
    try {
      _transactionState = transactionState;
      DebugLog().printLog(
          'transaction state [setAllTranction]: $_transactionState', 'info');
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      DebugLog().printLog(
          'transaction state [setAllTranction]: $_transactionState', 'info');
    }
  }

  void setSingleTransactionData(TransactionEntity singleTransactionData) {
    _singleTransactionData = singleTransactionData;
    _errorMessage = null;
    notifyListeners();
  }

  void cleanError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> fetchTransactionDataById(
      String? transactionId, TransactionPresenter transactionPresenter) async {
    setLoading(true);
    try {
      TransactionEntity? data =
          await transactionPresenter.getTransactionDetail(transactionId);

      setSingleTransactionData(data!);
    } catch (e) {
      setError(e.toString());
    }
  }
}
