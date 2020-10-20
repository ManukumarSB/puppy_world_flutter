import '../../common/services/storage_services.dart';

class StorageManager {
  static const String _tokenKey = '_user_auth_token_';
  static const String _userIdKey = '_user_id_';

  static Future<String> getAuthToken() async {
    final storageService = await StorageService.getInstance();
    return storageService.getValue(_tokenKey);
  }

  static Future<bool> setAuthToken(String value) async {
    final storageService = await StorageService.getInstance();
    return storageService.setValue(_tokenKey, value);
  }

  static Future<String> getUserId() async {
    final storageService = await StorageService.getInstance();
    return storageService.getValue(_userIdKey);
  }

  static Future<bool> setUserId(String value) async {
    final storageService = await StorageService.getInstance();
    return storageService.setValue(_userIdKey, value);
  }

  static clear() async {
    final storageService = await StorageService.getInstance();
    return storageService.clear();
  }
}
