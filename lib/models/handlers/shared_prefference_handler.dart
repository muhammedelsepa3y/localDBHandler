import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHandler {
  // Singleton instance for the SharedPreferencesHandler
  static final SharedPreferencesHandler _instance = SharedPreferencesHandler._internal();

  factory SharedPreferencesHandler() {
    return _instance;
  }

  SharedPreferencesHandler._internal();

  // Initialize SharedPreferences
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Methods for setting, getting, and deleting values

  // Set a String value
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Get a String value
  String getString(String key) {
    return _prefs.getString(key) ?? ''; // Provide a default value if the key doesn't exist
  }

  // Set an int value
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  // Get an int value
  int getInt(String key) {
    return _prefs.getInt(key) ?? 0; // Provide a default value if the key doesn't exist
  }

  // Set a boolean value
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  // Get a boolean value
  bool getBool(String key) {
    return _prefs.getBool(key) ?? false; // Provide a default value if the key doesn't exist
  }

  // Delete a value by key
  Future<void> delete(String key) async {
    await _prefs.remove(key);
  }

  // Clear all stored preferences (use with caution)
  Future<void> clear() async {
    await _prefs.clear();
  }
}
