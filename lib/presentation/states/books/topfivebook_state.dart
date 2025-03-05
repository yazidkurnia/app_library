import 'package:flutter/material.dart';

import '../../../domain/entities/book_entity.dart';

class TopFiveBookState with ChangeNotifier {
  List<BookEntity>? _topFiveBooks;
  bool _loading = false;
  String? _errorMessage;

  List<BookEntity>? get topFiveBooks => _topFiveBooks;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;

  void setTopFiveBooks(List<BookEntity> books) {
    _topFiveBooks = books;
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
