// digunakan untu menghandle error
// lib/core/errors/failure.dart

abstract class Failure {
  final String message;

  Failure(this.message);
}
