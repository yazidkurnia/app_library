import 'dart:convert';

import 'package:app_library/core/constants/app_constant.dart';

import '../../../core/networks/api_client.dart';

class RdsTransaction {
  final ApiClient apiClient;
  RdsTransaction(this.apiClient);

  Future<dynamic> storeTransaction(data) async {
    return await apiClient.post(
        AppConstants.storeTransactionEndpoint, jsonEncode(data));
  }
}
