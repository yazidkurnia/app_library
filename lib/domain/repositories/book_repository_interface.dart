//* class repository interface merupakan
//* class yang akan diimplementasikan pada class repository

import '../entities/book_entity.dart';

abstract class BookRepositoryInterface {
  Future<List<BookEntity>> getTopFiveBook();
  Future<List<BookEntity>> getAllBook();
  // Future<BookEntity?> getBookById(String bookId);
  // Future<List<BookEntity>> getBooksByCategory(String categoryId);
  // Future<bool> addBook(BookEntity book);
  // Future<bool> updateBook(BookEntity book);
  // Future<bool> deleteBook(String bookId);
}
