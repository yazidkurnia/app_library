// digunakan untuk menyimpan setiap constanta atau variable yang dapat diakses di semua halaman
// lib/core/constants/app_constants.dart

class AppConstants {
  static const String baseUrl = 'http://192.168.91.109:3000';

  //--------------------------------------------------------------------------------------------|
  //                                        ENDPOINT                                            |
  //--------------------------------------------------------------------------------------------|
  //* endpoint auth
  static const String signInEndpoint = '$baseUrl/sign-in';
  static const String signUpEndpoint = '$baseUrl/Sign-up';

  //* endpoint book
  static const String topFiveBookEndpointFromCategory =
      '$baseUrl/best_five_books';
  static const String allBookFromCategory = '$baseUrl/all-book';
  static const String detailBook =
      '$baseUrl/book/detail/'; //* membutuhkan parameter id

  //* endpoint transaction
  static const String storeTransactionEndpoint = '$baseUrl/api/send-data';
  static const String getStatusTransactionEndpoint =
      '$baseUrl/get/status-transaksi/';
}
