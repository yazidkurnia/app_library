// digunakan untuk menyimpan setiap constanta atau variable yang dapat diakses di semua halaman
// lib/core/constants/app_constants.dart

import 'package:logger/logger.dart';

class AppConstants {
  var logger = Logger();
  static const String baseUrl = 'http://192.168.56.1:3000';
  static const String signInEndpoint = '$baseUrl/sign-in';
  static const String signUpEndpoint = '$baseUrl/Sign-up';

  void printLog(String message, String type) {
    if (type == 'error') {
      return logger.e(message);
    }

    if (type == 'trace') {
      return logger.t(message);
    }

    if (type == 'warning') {
      return logger.w(message);
    }

    if (type == 'info') {
      return logger.i(message);
    }

    return logger.d(message);
  }
}
