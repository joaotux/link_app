import 'package:shared_preferences/shared_preferences.dart';

class SharedUtils {
  static late Future<SharedPreferences> _shared;

  SharedUtils() {
    _shared = SharedPreferences.getInstance();
  }

  Future<bool> setValueInt(String key, int value) async {
    bool sucess = false;
    final SharedPreferences shared = await _shared;
    await shared.setInt(key, value).then((result) => sucess = result);
    return sucess;
  }

  Future<bool> setValueString(String key, String value) async {
    bool sucess = false;
    final SharedPreferences shared = await _shared;
    await shared.setString(key, value).then((result) => sucess = result);
    return sucess;
  }

  Future<bool> setValueBool(String key, bool value) async {
    bool sucess = false;
    final SharedPreferences shared = await _shared;
    await shared.setBool(key, value).then((result) => sucess = result);
    return sucess;
  }

  Future<int> getValueInt(String key) async {
    final SharedPreferences shared = await _shared;
    return shared.getInt(key);
  }

  Future<String> getValueString(String key) async {
    final SharedPreferences shared = await _shared;
    return shared.getString(key);
  }

  Future<bool> getValueBool(String key) async {
    final SharedPreferences shared = await _shared;
    return shared.getBool(key);
  }
}
