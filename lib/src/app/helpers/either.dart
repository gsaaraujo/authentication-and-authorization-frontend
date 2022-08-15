abstract class Either<L, R> {
  L get left => this is Left<L, R>
      ? (this as Left<L, R>).value
      : throw Exception(
          'Illegal use. You should isLeft() check before calling ');

  R get right => this is Right<L, R>
      ? (this as Right<L, R>).value
      : throw Exception(
          'Illegal use. You should check isRight() before calling');

  bool isLeft() => this is Left<L, R>;
  bool isRight() => this is Right<L, R>;
}

class Left<L, R> extends Either<L, R> {
  final L value;
  Left(this.value);
}

class Right<L, R> extends Either<L, R> {
  final R value;
  Right(this.value);
}
