import 'package:thepos/features/login/data/login_service/login_errors.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

class LoginUseCaseOutputSpy extends LoginUseCaseOutput {
  List<LoginResult> loginSuccessCalls = <LoginResult>[];
  List<LoginErrors> loginFailedCalls = <LoginErrors>[];
  @override
  void onLoginSuccess(LoginResult result) {
    loginSuccessCalls.add(result);
  }

  @override
  void onLoginFail(LoginErrors error) {
    loginFailedCalls.add(error);
  }
}
