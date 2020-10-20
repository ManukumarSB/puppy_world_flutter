import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static StorageService _storageService;
  SharedPreferences _storageInstance;

  static Future<StorageService> getInstance() async {
    if (_storageService == null) {
      _storageService = StorageService();
      _storageService._storageInstance = await SharedPreferences.getInstance();
    }
    return _storageService;
  }

  String getValue(String key) {
    return _storageInstance.get(key);
  }

  Future<bool> setValue(String key, String value) async {
    return await _storageInstance.setString(key, value);
  }

  Future<bool> clear() async {
    return await _storageInstance.clear();
  }

  bool containsKey(String key) {
    return _storageInstance.containsKey(key);
  }
}
