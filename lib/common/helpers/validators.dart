class Validators {
  static RegExp _validEmailRegEx =
      new RegExp(r"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");

  static bool isValidEmail(String str) {
    return _validEmailRegEx.hasMatch(str.toLowerCase());
  }

  static String getDigits(String str) {
    return str.replaceAll(new RegExp(r"[^0-9]"), '');
  }

  static String firstNameValidator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Name Required';
    }
    if (value.length > 25) {
      return 'Name should not exceed 25 characters';
    }
    return null;
  }

  static bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
