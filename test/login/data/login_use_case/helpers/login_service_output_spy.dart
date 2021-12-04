import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

class LoginServiceOutputSpy extends LoginServiceOutput {
  LoginResult? receivedLoginResult;
  Object? receivedError;

  @override
  void onLoginSuccess(LoginResult result) {
    receivedLoginResult = result;
  }

  @override
  void onLoginFail(Object error) {
    receivedError = error;
  }
}
