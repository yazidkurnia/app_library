import '../entities/transaction_entity.dart';

abstract class TransactionRepositoryInterface {
  Future<bool> storeTransaction(List<String> data);
  Future<List<TransactionEntity>> getAllTransaction();
  Future<TransactionEntity> getTransactionById(String transactionId);
}
