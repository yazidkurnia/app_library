import 'package:logger/logger.dart';

class DebugLog {
  var logger = Logger();
  void printLog(dynamic message, String type) {
    if (message is Map) {
      // Jika message adalah Map, konversi ke string
      message = message.toString();
    }

    if (type == 'error') {
      logger.e(message);
    } else if (type == 'trace') {
      logger.t(message);
    } else if (type == 'warning') {
      logger.w(message);
    } else if (type == 'info') {
      logger.i(message);
    } else {
      logger.d(message);
    }
  }
}
