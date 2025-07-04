import 'package:dio/dio.dart';

class Failure {
  final String errorMessage;
  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection timeout, Please try again later.");

      case DioExceptionType.sendTimeout:
        return ServerFailure("Send timeout, Please try again later.");

      case DioExceptionType.receiveTimeout:
        return ServerFailure("Recive timeout, Please try again later.");
      case DioExceptionType.badCertificate:
        return ServerFailure("Bad Certificate, Please try again later.");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure("Request was cancelled.");
      case DioExceptionType.connectionError:
        return ServerFailure("No Internet Connection");
      case DioExceptionType.unknown:
        return ServerFailure("An unexpected error occurred.");
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    print(" Error Response [$statusCode]: $response");

    try {
      if (response is Map && response.containsKey("message")) {
        return ServerFailure(response["message"]);
      }

      if (response is String && response.isNotEmpty) {
        return ServerFailure(response);
      }

      if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
        return ServerFailure("Authentication error.");
      } else if (statusCode == 404) {
        return ServerFailure("The requested resource was not found.");
      } else if (statusCode == 500) {
        return ServerFailure("Internal server error. Please try again later.");
      } else {
        return ServerFailure("Oops! Something went wrong. [$statusCode]");
      }
    } catch (e) {
      return ServerFailure("Failed to parse error response: $e");
    }
  }
}
