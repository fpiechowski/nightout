import 'package:dartz/dartz.dart';

extension FutureFunctional<T> on Future<T> {
  tap(void Function(T value) function) {
    then((value) {
      function(value);
      return value;
    });
  }

  Future<Either<dynamic, T>>toEither(){
    return then((value) => Right(value), onError: (error) => Left(error));
  }
}
