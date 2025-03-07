import 'package:flutter/material.dart';

import '../../../domain/entities/book_entity.dart';

class AllBookState with ChangeNotifier {
  List<BookEntity>? _allBooks;
  bool _loading = false;
  String? _errorMessage;

  List<BookEntity>? get allBooks => _allBooks;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;

  void setAllBooks(List<BookEntity> books) {
    _allBooks = books;
    _errorMessage = null;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void setError(String messageError) {
    _errorMessage = messageError;
    notifyListeners();
  }

  void cleanError() {
    _errorMessage = null;
    notifyListeners();
  }
}
