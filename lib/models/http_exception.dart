class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  //This file is use to return HTTP Error code for error checking and handling in the app

  @override
  String toString() {
    return message;
  }
}
