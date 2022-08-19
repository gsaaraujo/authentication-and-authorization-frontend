import 'dart:developer';

class Failure {
  final String message;

  Failure(this.message) {
    log(message);
  }
}
