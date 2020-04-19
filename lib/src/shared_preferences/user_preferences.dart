import 'package:crud_flutter/src/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._();

  UserPreferences._();

  factory UserPreferences() {
    return _instance;
  }

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get token {
    return _prefs.getString('token') ?? null;
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get lastPage {
    return _prefs.getString('lastPage') ?? HomePage.routeName;
  }

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }
}
