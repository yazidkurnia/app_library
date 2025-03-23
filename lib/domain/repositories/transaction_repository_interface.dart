abstract class TransactionRepositoryInterface {
  Future<bool> storeTransaction(List<String> data);
}
