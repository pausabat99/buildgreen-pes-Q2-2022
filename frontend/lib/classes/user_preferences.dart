
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static SharedPreferences? _preferences;
  
  static const _keyToken = "token";
  
  static Future init() async => 
    _preferences = await SharedPreferences.getInstance();

  static Future setToken(String token) async =>
    _preferences?.setString(_keyToken,  token);
  
}