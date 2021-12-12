import 'package:thepos/features/login/data/login_service/login_errors.dart';

import '../login_service/login_service.dart';
import '../models/login_result.dart';
import 'login_use_case_output.dart';

class LoginUseCase {
  LoginUseCase({
    required this.loginService,
    required this.output,
  });

  final LoginService loginService;
  final LoginUseCaseOutput output;

  Future<void> login(String username, String password) async {
    try {
      final LoginResult result = await loginService.login(username, password);
      output.onLoginSuccess(result);
    } on LoginErrors catch (error) {
      output.onLoginFail(error);
    }
  }
}
