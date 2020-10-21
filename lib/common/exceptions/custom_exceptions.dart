class UserAuthException implements Exception {
  UserAuthException() : super();
  String errMsg() => 'Your message';
}

class NoInternetConnection implements Exception {
  NoInternetConnection() : super();
}

class UnknownErrrorOccured implements Exception {
  UnknownErrrorOccured() : super();
}

class UnexpectedServerError implements Exception {
  UnexpectedServerError() : super();
}
