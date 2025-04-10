import 'dart:convert';
import 'package:app_library/core/constants/debug_log.dart';

import '../../../core/constants/api_endpoint.dart';
import '../../../core/networks/api_client.dart';

class RdsTransaction {
  final ApiClient apiClient;
  RdsTransaction(this.apiClient);

  Future<dynamic> storeTransaction(data) async {
    return await apiClient.post(
        ApiEndpoint.storeTransactionEndpoint, jsonEncode(data));
  }

  Future<dynamic> getTransactionState() async {
    DebugLog().printLog(ApiEndpoint.getStatusTransactionEndpoint, 'error');
    return await apiClient.get(ApiEndpoint.getStatusTransactionEndpoint);
  }

  Future<dynamic> getTransactionDetail(String transactionId) async {
    return await apiClient
        .get('${ApiEndpoint.detail_transaction_endpoint}/$transactionId');
  }
}
