import 'package:shared_preferences/shared_preferences.dart';

import 'login_use_case/login_use_case_output.dart';
import 'models/login_result.dart';

class AuthManager extends LoginUseCaseOutput {
  AuthManager(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  static const String PREF_USER_TOKEN = 'userToken';

  @override
  void onLoginSuccess(LoginResult result) {
    sharedPreferences.setString(PREF_USER_TOKEN, result.token);
  }
}