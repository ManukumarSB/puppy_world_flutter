import '../../common/services/storage_services.dart';

class StorageManager {
  final String _tokenKey = '_pw_token';
  final String _userIdKey = '_pw_user_id';
  Future<String> getToken() async {
    final storageService = await StorageService.getInstance();
    return storageService.getValue(_tokenKey);
  }

  Future<bool> setToken(String value) async {
    final storageService = await StorageService.getInstance();
    return storageService.setValue(_tokenKey, value);
  }

  Future<String> getUserId() async {
    final storageService = await StorageService.getInstance();
    return storageService.getValue(_userIdKey);
  }

  Future<bool> setUserId(String value) async {
    final storageService = await StorageService.getInstance();
    return storageService.setValue(_userIdKey, value);
  }

  clearAllData() async {
    final storageService = await StorageService.getInstance();
    return storageService.clear();
  }
}
