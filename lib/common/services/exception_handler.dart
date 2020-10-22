import 'package:puppy_world/common/exceptions/custom_exceptions.dart';
import 'package:puppy_world/common/helpers/response_codes.dart';
import 'package:puppy_world/common/services/rest_api_request.dart';

extension ExceptionHandler on RestApiResponse {
  handleException() {
    if (success) {
      return;
    }
    var badResponse = getBadResponseObject();
    switch (badResponse.code) {
      case ResponseCodes.success: //1
        // message = "Success.";
        break;
      case ResponseCodes.userNotFound: //2
        // message = "User not found.";
        break;
      case ResponseCodes.userIncorrectPassword: //3
        throw IncorrectPasswordException(badResponse.message);
        break;
      case ResponseCodes.userAccountByIdNotFound: //4
        break;
      case ResponseCodes.userAccountByEmailNotFound: //5
        break;
      case ResponseCodes.userInvalidEmail: //6
        break;
      case ResponseCodes.userInvalidPassword: //7
        break;
      case ResponseCodes.userDuplicateEmail: //8
        throw DuplicateEmailException(badResponse.message);

        break;
      case ResponseCodes.userDuplicateMobile: //9
        throw DuplicateMobileException(badResponse.message);
        break;
      case ResponseCodes.userCreateInvalidOrEmpty: //10
        break;
      case ResponseCodes.userProfileImageUnsupportedFormat: //11

        break;
      case ResponseCodes.userProfileImageTooLarge: //12
        break;
      case ResponseCodes.userPasswordSameAsOld: //14
        break;
      case ResponseCodes.userInvalidNewPassword: //15
        break;
      case ResponseCodes.profileTilesLimitEmpty: //16
        break;
      case ResponseCodes.profileIdNotFound: //17
        break;
      default:
        break;
    }
    return 'bad response message';
  }
}
