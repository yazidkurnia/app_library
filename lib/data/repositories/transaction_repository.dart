import 'package:app_library/core/constants/debug_log.dart';
import 'package:app_library/domain/repositories/transaction_repository_interface.dart';

import '../data_sources/remote_data_source/rds_transaction.dart';

class TransactionRepository implements TransactionRepositoryInterface {
  final RdsTransaction rdsTransaction;

  TransactionRepository(this.rdsTransaction);

  Future<bool> storeTransaction(List<String> data) async {
    final response = await rdsTransaction.storeTransaction(data);

    DebugLog()
        .printLog('transaction store response: ${response['meta']}', 'info');
    if (response['meta']['code'] == 200) {
      return true;
    } else {
      return false;
    }
  }
}
