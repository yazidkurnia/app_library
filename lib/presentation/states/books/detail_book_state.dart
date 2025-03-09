import 'package:flutter/material.dart';

import '../../../domain/entities/book_entity.dart';

class DetailBookState with ChangeNotifier {
  BookEntity? _detailBook;
  bool _loading = false;
  String? _errorMessage;

  BookEntity? get detailBook => _detailBook;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;

  void setDetailBook(BookEntity books) {
    _detailBook = books;
    _errorMessage = null;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
