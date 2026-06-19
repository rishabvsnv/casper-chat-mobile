abstract class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException()
    : super('Session expired. Please login again.', statusCode: 401);
}

class NetworkException extends ApiException {
  const NetworkException() : super('No internet connection. Please try again.');
}

class BadRequestException extends ApiException {
  const BadRequestException(super.message) : super(statusCode: 400);
}

class ServerException extends ApiException {
  const ServerException(super.message, {super.statusCode});
}
