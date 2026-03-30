import 'failure.dart';

abstract class ApiResult<T> {
  const ApiResult();

  factory ApiResult.success(T data) = Success<T>;
  factory ApiResult.failure(Failure failure) = Fail<T>;

  R fold<R>(
    R Function(T data) onSuccess,
    R Function(Failure failure) onFailure,
  ) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else {
      return onFailure((this as Fail<T>).failure);
    }
  }
}

class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

class Fail<T> extends ApiResult<T> {
  final Failure failure;
  const Fail(this.failure);
}
