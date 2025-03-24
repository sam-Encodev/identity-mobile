import 'package:identity/constants/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late final SharedPreferences _prefsInstance;

  static Future init() async =>
      _prefsInstance = await SharedPreferences.getInstance();

  static bool get() => _prefsInstance.getBool(key) ?? false;

  static Future<void> setValue(bool value) async => {
    await _prefsInstance.setBool(key, value),
  };

  static Future<bool> deleteValue() async => _prefsInstance.remove(key);
}
