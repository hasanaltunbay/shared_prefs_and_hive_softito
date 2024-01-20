import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late final SharedPreferences _sharedPrefs;

  static Future<bool> initService() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    return true;
  }

  Future<bool> setInt(String key, int value) {
    return _sharedPrefs.setInt(key, value);
  }

  Future<bool> setBool(String key, bool value) {
    return _sharedPrefs.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) {
    return _sharedPrefs.setDouble(key, value);
  }

  Future<bool> setString(String key, String value) {
    return _sharedPrefs.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _sharedPrefs.setStringList(key, value);
  }

  Future<bool> setMap(String key, Map<String, dynamic> value) {
    return _sharedPrefs.setString(key, jsonEncode(value));
  }

  Map<String, dynamic> getMap(String key) =>
      Map<String, dynamic>.from(jsonDecode(_sharedPrefs.getString(key)!));

  int? getInt(String key) => _sharedPrefs.getInt(key);

  bool? getBool(String key) => _sharedPrefs.getBool(key);

  double? getDouble(String key) => _sharedPrefs.getDouble(key);

  String? getString(String key) => _sharedPrefs.getString(key);
  List<String>? getStringList(String key) => _sharedPrefs.getStringList(key);

  Future<bool> clear() {
    return _sharedPrefs.clear();
  }
}
