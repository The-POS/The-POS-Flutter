import '../login_service/login_errors.dart';
import '../models/login_result.dart';

abstract class LoginUseCaseOutput {
  void onLoginSuccess(LoginResult result);
  void onLoginFail(LoginErrors error) {}
}
