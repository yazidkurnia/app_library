import '../../repositories/transaction_repository_interface.dart';

class PostTransactionUseCase {
  final TransactionRepositoryInterface tri_repository;

  PostTransactionUseCase(this.tri_repository);

  Future<bool> storeTransaction(List<String> data) async {
    return await tri_repository.storeTransaction(data);
  }
}
