import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  SharedPreferenceManager._();

  static late SharedPreferences _instance;

  static Future<SharedPreferences> init() async {
    _instance = await SharedPreferences.getInstance();
    return _instance;
  }

  static final SharedPreferenceManager _singleton = SharedPreferenceManager._();
  static SharedPreferenceManager get sharedInstance => _singleton;

  static SharedPreferences get instance => _instance;

  final String getStartedKey = 'get_started';
  final String languageIndexKey = 'language_index';
  final String langCodeKey = 'lang_code';

  Future<bool> storeGetStarted(bool value) =>
      _instance.setBool(getStartedKey, value);
  bool getStartedCheck() => _instance.getBool(getStartedKey) ?? false;

  Future<bool> storeLangCode(String code) =>
      _instance.setString(langCodeKey, code);
  String getLangCode() => _instance.getString(langCodeKey) ?? 'en';

  Future<bool> storeInt(String key, int value) => _instance.setInt(key, value);
  int? getInt(String key) => _instance.getInt(key);

  Future<bool> storeString(String key, String value) =>
      _instance.setString(key, value);
  String? getString(String key) => _instance.getString(key);

  Future<bool> storeBool(String key, bool value) =>
      _instance.setBool(key, value);
  bool? getBool(String key) => _instance.getBool(key);

  Future<bool> clearKey(String key) => _instance.remove(key);
  Future<bool> clearAll() => _instance.clear();
}
