import 'package:thepos/features/login/data/login_service/login_errors.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

class LoginServiceOutputSpy extends LoginUseCaseOutput {
  LoginResult? receivedLoginResult;
  LoginErrors? receivedError;

  @override
  void onLoginSuccess(LoginResult result) {
    receivedLoginResult = result;
  }

  @override
  void onLoginFail(LoginErrors error) {
    receivedError = error;
  }
}
