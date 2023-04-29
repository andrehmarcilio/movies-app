import 'dart:async';

abstract class Either<L, R> {
  bool get isSuccess => this is Success<L, R>;
  bool get isFailure => this is Failure<L, R>;

  R get successData {
    assert(isSuccess, 'Cannot get success value from a Failure Either');
    return (this as Success<L, R>)._success;
  }

  L get failureData {
    assert(isFailure, 'Cannot get failure value from a Success Either');
    return (this as Failure<L, R>)._failure;
  }

  FutureOr<void> fold({FutureOr<void> Function(L)? failure, FutureOr<void> Function(R)? success}) {
    if (isSuccess) {
      success?.call(successData);
    } else {
      failure?.call(failureData);
    }
  }
}

class Success<L, R> extends Either<L, R> {
  final R _success;

  Success(this._success);
}

class Failure<L, R> extends Either<L, R> {
  final L _failure;

  Failure(this._failure);
}
