import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/login_service/api_login/api_login_errors.dart';
import 'package:thepos/features/login/data/login_service/login_service.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

import 'helpers/shared_test_helper.dart';

void main() {
  test('login deliver the result to the output on success case', () async {
    final LoginResult loginResult = LoginResult(
      token: 'token',
      user: 'user',
      expire: 0,
      displayName: 'displayName',
    );
    final LoginServiceStub loginService = LoginServiceStub(result: loginResult);

    final LoginServiceOutputSpy output = LoginServiceOutputSpy();

    final LoginUseCase useCase = LoginUseCase(
      loginService: loginService,
      output: output,
    );
    await useCase.login('salahnahed', '123');

    expectLoginResult(output.receivedLoginResult, loginResult);
  });

  test('login deliver the error to the output on failed case', () async {
    const ApiLoginErrors error = ApiLoginErrors.invalidData;
    final LoginServiceStub loginService = LoginServiceStub(error: error);

    final LoginServiceOutputSpy output = LoginServiceOutputSpy();

    final LoginUseCase useCase = LoginUseCase(
      loginService: loginService,
      output: output,
    );
    await useCase.login('salahnahed', '123');
    expect(output.receivedError, error);
  });
}

class LoginServiceStub extends LoginService {
  LoginServiceStub({this.result, this.error});

  final LoginResult? result;
  final Object? error;

  @override
  Future<LoginResult> login(String username, String password) {
    return error != null
        ? Future<LoginResult>.error(error!)
        : Future<LoginResult>.value(result);
  }
}

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
