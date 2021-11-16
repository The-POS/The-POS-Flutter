import 'dart:async' show Future;

import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class PreferenceUtils {
  static const String PREF_CACHE_TIME = 'cachedProductTime';

  static Future<SharedPreferences> get _instance async =>
      prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefs;

  static Future<SharedPreferences> init() async {
    prefs = await _instance;
    return prefs!;
  }

  static String _getString(String key, [String? defValue]) {
    return prefs!.getString(key) ?? '';
  }

  static Future<int> _getInt(String key) async {
    final SharedPreferences prefs = await _instance;
    return prefs.getInt(key) ?? 0;
  }

  static Future<bool> _setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static Future<bool> _setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> _setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static bool _getBool(String key) {
    return prefs!.getBool(key) ?? true;
  }

  static Future<void> clearAllPreferences() async {
    prefs!.clear();
  }

  static Future<int> getCacheTime() {
    return _getInt(PREF_CACHE_TIME);
  }

  static void setCacheTime(int time) {
    _setInt(PREF_CACHE_TIME, time);
  }
}
