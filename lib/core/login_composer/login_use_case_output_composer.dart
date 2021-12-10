import 'package:thepos/features/login/data/login_service/login_errors.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

class LoginUseCaseOutputComposer extends LoginUseCaseOutput {
  LoginUseCaseOutputComposer(this.outputs);

  final List<LoginUseCaseOutput> outputs;
  @override
  void onLoginSuccess(LoginResult result) {
    for (final LoginUseCaseOutput output in outputs) {
      output.onLoginSuccess(result);
    }
  }

  @override
  void onLoginFail(LoginErrors error) {
    for (final LoginUseCaseOutput output in outputs) {
      output.onLoginFail(error);
    }
  }
}
