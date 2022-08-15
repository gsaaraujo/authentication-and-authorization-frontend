import 'dart:developer';

abstract class Failure {
  final String message;

  Failure(this.message) {
    log(message);
  }
}
