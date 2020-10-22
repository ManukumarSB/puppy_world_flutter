class Validators {
  static const int _passwordMinLength = 6;
  static const int _passwordMaxLength = 20;

  static const int _mobileLength = 10;

  static RegExp _validEmailRegEx =
      new RegExp(r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$');

  static RegExp _validPasswordRegEx = new RegExp(
      '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{$_passwordMinLength,$_passwordMaxLength}' +
          r'$');

  static RegExp _validMobileRegEx = new RegExp('^[0-9]{$_mobileLength}' + r'$');

  static String validateName(String name) {
    if ((name?.trim()?.isEmpty) ?? true) {
      return 'Name cannot be empty';
    } else if (name.length < 3 || name.length > 25) {
      return 'Name length should be [3-25]';
    }
    return null;
  }

  static String validateEmail(String email) {
    if ((email?.trim()?.isEmpty) ?? true) {
      return 'Email cannot be empty';
    } else {
      var hasMatch = _validEmailRegEx.hasMatch(email);
      return hasMatch ? null : "Invalid email address";
    }
  }

  static String validatePassword(String password) {
    if (password?.isEmpty ?? true) {
      return "Password cannot be empty";
    } else {
      return _validPasswordRegEx.hasMatch(password)
          ? null
          : "Use $_passwordMinLength-$_passwordMaxLength characters with a mix of upper-case, lower-case, number and '!@#\$&*~'";
    }
  }

  static String validateMobile(String input) {
    if ((input?.trim()?.isEmpty) ?? true) {
      return 'Mobile number cannot be empty';
    } else {
      return _validMobileRegEx.hasMatch(input)
          ? null
          : "Enter 10 digit mobile number";
    }
  }
}
