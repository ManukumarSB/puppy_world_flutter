class ResponseCodes {
  static const int success = 0; //1
  static const int userNotFound = -100; //2
  static const int userIncorrectPassword = -101; //3
  static const int userAccountByIdNotFound = -102; //4
  static const int userAccountByEmailNotFound = -103; //5
  static const int userInvalidEmail = -104; //6
  static const int userInvalidPassword = -105; //7
  static const int userDuplicateEmail = -106; //8
  static const int userDuplicateMobile = -107; //9
  static const int userCreateInvalidOrEmpty = -108; //10
  static const int userProfileImageUnsupportedFormat = -109; //11
  static const int userProfileImageTooLarge = -110; //12
  static const int userPasswordSameAsOld = -111; //13
  static const int userInvalidNewPassword = -112; //14
  static const int profileTilesLimitEmpty = -113; //15
  static const int profileIdNotFound = -114; //16
}

class ResponseCodesHelper {
  static triggerException(int responseCode, String message) {
    //TODO
  }

  //Override response message if required
  static String getMessage(int responseCode) {
    String message;
    switch (responseCode) {
      case ResponseCodes.success: //1
        message = "Success.";
        break;
      case ResponseCodes.userNotFound: //2
        message = "User not found.";
        break;
      case ResponseCodes.userIncorrectPassword: //3
        message = "Incorrect password.";
        break;
      case ResponseCodes.userAccountByIdNotFound: //4
        message = "User with given id not found.";
        break;
      case ResponseCodes.userAccountByEmailNotFound: //5
        message = "User with given email not found.";
        break;
      case ResponseCodes.userInvalidEmail: //6
        message = "Invalid email address.";
        break;
      case ResponseCodes.userInvalidPassword: //7
        message = "Invalid password.";
        break;
      case ResponseCodes.userDuplicateEmail: //8
        message = "Email already in use.";
        break;
      case ResponseCodes.userDuplicateMobile: //9
        message = "Mobile already in use.";
        break;
      case ResponseCodes.userCreateInvalidOrEmpty: //10
        message = "User details/password are empty.";
        break;
      case ResponseCodes.userProfileImageUnsupportedFormat: //11
        message =
            "Unsupported image format, only png,jpg and jpeg are accepted.";
        break;
      case ResponseCodes.userProfileImageTooLarge: //12
        message = "Profile image cannot exceed 1Mb.";
        break;
      case ResponseCodes.userPasswordSameAsOld: //14
        message = "New password cannot be same as old password.";
        break;
      case ResponseCodes.userInvalidNewPassword: //15
        message = "Invalid new password.";
        break;
      case ResponseCodes.profileTilesLimitEmpty: //16
        message = "'limit' cannot be empty.";
        break;
      case ResponseCodes.profileIdNotFound: //17
        message = "No profile found with id given id.";
        break;
      default:
        break;
    }
    return message;
  }
}
