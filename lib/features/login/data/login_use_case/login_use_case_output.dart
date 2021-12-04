import 'package:thepos/features/login/data/models/login_result.dart';

abstract class LoginServiceOutput {
  void onLoginSuccess(LoginResult result);
  void onLoginFail(Object error);
}
