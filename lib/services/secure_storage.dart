import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  SecureStorageManager._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static final SecureStorageManager _instance = SecureStorageManager._();
  static SecureStorageManager get sharedInstance => _instance;

  static const _tokenKey = 'auth_token';
  static const _userDataKey = 'user_data';

  Future<void> writeToken(String token) =>
      _storage.write(key: _tokenKey, value: token);
  Future<String?> readToken() => _storage.read(key: _tokenKey);
  Future<bool> hasToken() async => (await readToken()) != null;
  Future<void> deleteToken() => _storage.delete(key: _tokenKey);

  Future<void> writeUserData(String data) =>
      _storage.write(key: _userDataKey, value: data);
  Future<String?> getUserData() => _storage.read(key: _userDataKey);

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
