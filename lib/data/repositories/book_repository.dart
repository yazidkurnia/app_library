//* class docs
//* class repository mengimplementasikan class repositoryinterface
//* yang artinya penamaan fungsi pada class repository harus sama dengan
//* yang ada pada class repository interface

import '../../core/constants/debug_log.dart';
import '../../core/errors/server_failure.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository_interface.dart';
import '../data_sources/remote_data_source.dart';
import '../models/book/book_model.dart';

class BookRepository implements BookRepositoryInterface {
  final RemoteDataSource remoteDataSource;

  BookRepository(this.remoteDataSource);

  @override
  Future<List<BookEntity>> getTopFiveBook() async {
    try {
      final response = await remoteDataSource.getTopFiveBook();
      DebugLog().printLog(
          'Response from API: $response', 'info'); // Tambahkan log ini

      if (response['meta']['code'] == 200) {
        final List<dynamic> topFiveBooksData = response['data'];
        return topFiveBooksData
            .map((e) => BookModel.fromJson(e).bookEntity())
            .toList();
      } else {
        var message = response['meta']['message'];
        String errorMessage;

        if (message is String) {
          errorMessage = message;
        } else if (message is Map) {
          errorMessage = message.toString();
        } else {
          errorMessage = 'An error occurred during sign in';
        }

        throw ServerFailure(errorMessage);
      }
    } catch (e) {
      DebugLog().printLog('Error: $e', 'error'); // Tambahkan log di sini
      throw Exception(e);
    }
  }

  // todo: get all book
  @override
  Future<List<BookEntity>> getAllBook() async {
    try {
      final response = await remoteDataSource.getAllBooks();
      DebugLog().printLog('Get ll book response callback: $response', 'info');
      if (response['meta']['code'] == 200) {
        final List<dynamic> allbook = response['data'];
        return allbook.map((e) => BookModel.fromJson(e).bookEntity()).toList();
      } else {
        var message = response['meta']['message'];
        String errorMessage;

        if (message is String) {
          errorMessage = message;
        } else if (message is Map) {
          errorMessage = message.toString();
        } else {
          errorMessage = 'Something wrong can not fetch data';
        }

        throw ServerFailure(errorMessage);
      }
    } catch (e) {
      DebugLog().printLog('Error: $e', 'error');
      throw Exception(e);
    }
  }

  @override
  Future<BookEntity?> getBookById(String bookId) async {
    try {
      final response = await remoteDataSource.getBookDetail(bookId);
      DebugLog().printLog('$response', 'warning');

      // Pastikan response tidak null dan memiliki struktur yang benar
      if (response != null && response['meta']['code'] == 200) {
        final dynamic detailBook = response['data'];
        return BookModel.fromJson(detailBook)
            .bookEntity(); // Konversi ke BookEntity
      } else {
        var message = response['meta']['message'];
        String errorMessage;

        if (message is String) {
          errorMessage = message;
        } else if (message is Map) {
          errorMessage = message.toString();
        } else {
          errorMessage = 'Something wrong can not fetch data';
        }

        throw ServerFailure(errorMessage);
      }
    } catch (e) {
      DebugLog().printLog('Error: $e', 'error');
      throw Exception(e);
    }
  }
}
