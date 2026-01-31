class AppException implements Exception {
  final String? message;
  final int? code;

  AppException([this.code, this.message]);

  @override
  String toString() => "$code $message";
}

class BadRequestException extends AppException {
  BadRequestException([super.code, super.message]);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([super.code, super.message]);
}

class NotFoundRequestException extends AppException {
  NotFoundRequestException([super.code, super.message]);
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException([super.code, super.message]);
}

class FetchDataException extends AppException {
  FetchDataException([super.code, super.message]);
}

class ServerException extends AppException {
  ServerException([super.code, super.message]);
}
