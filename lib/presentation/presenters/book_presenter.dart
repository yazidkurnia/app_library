import 'package:app_library/core/constants/app_constant.dart';
import 'package:app_library/domain/usecases/books/get_book_usecase.dart';

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
}
