// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesHelper {
//   static const _keyUserId = 'userId';

//   static Future<void> saveUserId(String userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserId, userId);
//   }

//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserId);
//   }

//   static Future<void> clearUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyUserId);
//   }
// }


import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _keyUserId = 'userId';
  static const _keyAuthToken = 'authToken';

  // Save user ID
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
  }

  // Get user ID
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  // Clear user ID
  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
  }

  // Save token
  static Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAuthToken, token);
  }

  // Get token
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAuthToken);
  }

  // Clear token
  static Future<void> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAuthToken);
  }
}
