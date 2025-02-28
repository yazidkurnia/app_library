import 'package:flutter/material.dart';
import '../core/networks/api_client.dart';

class ApiProvider with ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  dynamic _data;
  bool _loading = false;

  dynamic get data => _data;
  bool get loading => _loading;

  Future<void> fetchData(String endpoint) async {
    _loading = true;
    notifyListeners();

    _data = await _apiClient.get(endpoint);
    _loading = false;
    notifyListeners();
  }
}
