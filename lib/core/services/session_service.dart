// import 'package:shared_preferences/shared_preferences.dart';
//
// class SessionService {
//   SessionService._();
//
//   static const String _isLoggedInKey = "is_logged_in";
//
//   static Future<void> saveLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     await prefs.setBool(_isLoggedInKey, true);
//   }
//
//   static Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     await prefs.setBool(_isLoggedInKey, false);
//   }
//
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     return prefs.getBool(_isLoggedInKey) ?? false;
//   }
// }