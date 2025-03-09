import 'package:app_library/domain/usecases/books/get_book_usecase.dart';
import 'package:app_library/presentation/states/books/detail_book_state.dart';

import '../../core/constants/debug_log.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/book_entity.dart';

class BookPresenter {
  final GetBookUseCase getBookUseCase;

  BookPresenter(this.getBookUseCase);

  Future<List<BookEntity?>> getTopFiveBooks() async {
    try {
      DebugLog().printLog('Fetching top five books...', 'info');
      return await getBookUseCase.getTopFiveBooks();
    } catch (e) {
      if (e is Failure) {
        DebugLog().printLog(e.message, 'error');
      }
      DebugLog()
          .printLog('Error occurred: $e', 'error'); // Tambahkan log di sini
      return [];
    }
  }

  Future<List<BookEntity>> getAllBook() async {
    try {
      DebugLog().printLog('Fethcing data', 'info');
      return await getBookUseCase.getAllBook();
    } catch (e) {
      if (e is Failure) {
        DebugLog().printLog(e.message, 'error');
      }
      DebugLog()
          .printLog('Error occurred: $e', 'error'); // Tambahkan log di sini
      return [];
    }
  }

  Future<BookEntity?> getDetailBook(bookId) async {
    final DetailBookState _state = DetailBookState();
    try {
      _state.setLoading(true);
      DebugLog().printLog('proses fetch data', 'info');
      final book = await getBookUseCase.getDetailBook(bookId);
      if (book == null) {
        DebugLog().printLog('Book not found', 'warning');
      }
      _state.setLoading(false);
      return book;
    } catch (e) {
      _state.setLoading(false);
      if (e is Failure) {
        DebugLog().printLog(e.message, 'error');
      }
      DebugLog().printLog('Error occurred: $e', 'error');
      return null;
    }
  }
}
