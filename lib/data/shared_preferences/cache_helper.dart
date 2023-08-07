import 'package:shared_preferences/shared_preferences.dart';


enum CacheHelperKeys{
  token,
  lang,
  theme_mode,
}


class CacheHelper {


  static Future<void> saveData(CacheHelperKeys keyValue, dynamic value) async {
    String key = keyValue.name;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    }
  }

  static Future<dynamic?> getData(CacheHelperKeys key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key.name);
  }

  static Future<void> removeData(CacheHelperKeys key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key.name);
  }

}
