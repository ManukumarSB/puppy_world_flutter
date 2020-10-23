class PuppyWorldException implements Exception {
  String message;
  PuppyWorldException(this.message) : super();
  @override
  String toString() => this.message ?? 'Some error occurred';
}

class UserAuthException extends PuppyWorldException {
  UserAuthException(String message) : super(message);
  @override
  String toString() => this.message ?? 'Please login to continue';
}

class NoInternetConnection extends PuppyWorldException {
  NoInternetConnection(String message) : super(message);
  @override
  String toString() => this.message ?? 'No internet connection';
}

class UnknownErrorOccurred extends PuppyWorldException {
  UnknownErrorOccurred(String message) : super(message);
  @override
  String toString() => this.message ?? 'Unknown error occurred';
}

class UnexpectedServerError extends PuppyWorldException {
  UnexpectedServerError(String message) : super(message);
  @override
  String toString() => this.message ?? 'Unexpected server error';
}

class UserNameExistsException extends PuppyWorldException {
  UserNameExistsException(String message) : super(message);
  @override
  String toString() =>
      this.message ??
      'Email address already exists. Please enter your password to sign in.';
}

class IncorrectPasswordException extends PuppyWorldException {
  IncorrectPasswordException(String message) : super(message);
  @override
  String toString() => this.message ?? 'You entered wrong password';
}

class DuplicateMobileException extends PuppyWorldException {
  DuplicateMobileException(String message) : super(message);
  @override
  String toString() => this.message ?? 'this phone-number already exist';
}

class DuplicateEmailException extends PuppyWorldException {
  DuplicateEmailException(String message) : super(message);
  @override
  String toString() => this.message ?? 'this Email already exist';
}

class ProfileImageTooLargeException extends PuppyWorldException {
  ProfileImageTooLargeException(String message) : super(message);
  @override
  String toString() => this.message ?? 'profile image is too large';
}
