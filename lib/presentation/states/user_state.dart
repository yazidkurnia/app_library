// lib/presentation/state/user_state.dart

import 'package:flutter/foundation.dart';
import '../../domain/entities/user_entity.dart';

class UserState with ChangeNotifier {
  UserEntity? _user;
  bool _loading = false;
  String? _errorMessage;

  UserEntity? get user => _user;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;

  void setUser(UserEntity user) {
    _user = user;
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
}
