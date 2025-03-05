import 'package:app_library/core/constants/app_constant.dart';
import 'package:app_library/domain/usecases/books/get_book_usecase.dart';

import '../../core/errors/failure.dart';
import '../../domain/entities/book_entity.dart';

class BookPresenter {
  final GetBookUseCase getBookUseCase;

  BookPresenter(this.getBookUseCase);

  Future<List<BookEntity?>> getTopFiveBooks() async {
    try {
      AppConstants().printLog('Fetching top five books...', 'info');
      return await getBookUseCase.getTopFiveBooks();
    } catch (e) {
      if (e is Failure) {
        AppConstants().printLog(e.message, 'error');
      }
      AppConstants()
          .printLog('Error occurred: $e', 'error'); // Tambahkan log di sini
      return [];
    }
  }

  Future<List<BookEntity>> getAllBook() async {
    try {
      AppConstants().printLog('Fethcing data', 'info');
      return await getBookUseCase.getAllBook();
    } catch (e) {
      if (e is Failure) {
        AppConstants().printLog(e.message, 'error');
      }
      AppConstants()
          .printLog('Error occurred: $e', 'error'); // Tambahkan log di sini
      return [];
    }
  }
}
