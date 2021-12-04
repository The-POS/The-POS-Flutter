import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/login_result.dart';
import 'package:thepos/features/login/data/login_service.dart';

import 'helpers/shared_test_helper.dart';

void main() {
  test('login deliver the result to the output on success case', () async {
    final LoginResult loginResult = LoginResult(
      token: 'token',
      user: 'user',
      expire: 0,
      displayName: 'displayName',
    );
    final LoginServiceStub loginService = LoginServiceStub(loginResult);

    final LoginServiceOutputSpy output = LoginServiceOutputSpy();

    final LoginUseCase useCase = LoginUseCase(
      loginService: loginService,
      output: output,
    );
    await useCase.login('salahnahed', '123');

    expectLoginResult(output.receivedLoginResult, loginResult);
  });
}

class LoginServiceStub extends LoginService {
  LoginServiceStub(this.result);

  final LoginResult result;

  @override
  Future<LoginResult> login(String username, String password) {
    return Future<LoginResult>.value(result);
  }
}

class LoginServiceOutputSpy extends LoginServiceOutput {
  LoginResult? receivedLoginResult;

  @override
  void onLoginSuccess(LoginResult result) {
    receivedLoginResult = result;
  }
}

abstract class LoginServiceOutput {
  void onLoginSuccess(LoginResult result);
}

class LoginUseCase {
  LoginUseCase({
    required this.loginService,
    required this.output,
  });

  final LoginService loginService;
  final LoginServiceOutput output;

  Future<void> login(String username, String password) async {
    final LoginResult result = await loginService.login(username, password);
    output.onLoginSuccess(result);
  }
}
