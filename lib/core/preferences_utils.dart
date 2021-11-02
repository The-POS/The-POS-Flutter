


import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

// ignore: avoid_classes_with_only_static_members
class PreferenceUtils {
   static const PREF_CACHETIME = 'cachedProductTime';

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
   static int _getInt(String key) {
     return prefs!.getInt(key) ?? 0;
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
  static int getCacheTime() {
    return _getInt(PREF_CACHETIME);
  }
   static void setCacheTime(int time) {
     _setInt(PREF_CACHETIME, time);
   }

}