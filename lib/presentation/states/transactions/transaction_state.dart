import 'package:flutter/foundation.dart';

import '../../../domain/entities/transaction_entity.dart';

class TransactionState with ChangeNotifier {
  List<TransactionEntity>? _transactionState;
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
    _transactionState = transactionState;
    _errorMessage = null;
    notifyListeners();
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
}
