// digunakan untuk menyimpan setiap constanta atau variable yang dapat diakses di semua halaman
// lib/core/constants/app_constants.dart

import 'package:logger/logger.dart';

class AppConstants {
  var logger = Logger();
  static const String baseUrl = 'http://192.168.56.1:3000';

  //--------------------------------------------------------------------------------------------|
  //                                        ENDPOINT                                            |
  //--------------------------------------------------------------------------------------------|
  //* endpoint auth
  static const String signInEndpoint = '$baseUrl/sign-in';
  static const String signUpEndpoint = '$baseUrl/Sign-up';

  //* endpoint book
  static const String topFiveBookEndpoint = '$baseUrl/best_five_books';
  static const String allBook = '$baseUrl/all-book';
  static const String detailBook =
      '$baseUrl/book/detail/'; //* membutuhkan parameter id
}
