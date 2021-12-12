import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepos/core/auth_manager.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

void main() {
  test('auth manager should save login result token on success case', () async {
    SharedPreferences.setMockInitialValues(<String, String>{});

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final AuthManager authManager = AuthManager(sharedPreferences);

    const String token = 'any token';
    final LoginResult loginResult = LoginResult(
      token: token,
      user: 'user',
      expire: 0,
      displayName: 'displayName',
    );

    authManager.onLoginSuccess(loginResult);

    final String? storedToken =
        sharedPreferences.getString(AuthManager.PREF_USER_TOKEN);

    expect(storedToken, token);
  });
}
