import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/login_service/login_errors.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

import '../helpers/shared_test_helper.dart';
import 'helpers/login_service_output_spy.dart';
import 'helpers/login_service_stub.dart';
import 'helpers/login_use_case_sut.dart';

void main() {
  LoginUseCaseSUT makeSUT({LoginResult? loginResult, Object? error}) {
    final LoginServiceStub loginService = LoginServiceStub(
      result: loginResult,
      error: error,
    );

    final LoginServiceOutputSpy output = LoginServiceOutputSpy();

    final LoginUseCase useCase = LoginUseCase(
      loginService: loginService,
      output: output,
    );
    return LoginUseCaseSUT(
      service: loginService,
      output: output,
      useCase: useCase,
    );
  }

  test('login deliver the result to the output on success case', () async {
    final LoginResult loginResult = LoginResult(
      token: 'token',
      user: 'user',
      expire: 0,
      displayName: 'displayName',
    );
    final LoginUseCaseSUT sut = makeSUT(loginResult: loginResult);

    await sut.useCase.login('salahnahed', '123');

    expectLoginResult(
        (sut.output as LoginServiceOutputSpy).receivedLoginResult, loginResult);
  });

  test('login deliver the error to the output on failed case', () async {
    const LoginErrors error = LoginErrors.invalidData;

    final LoginUseCaseSUT sut = makeSUT(error: error);

    await sut.useCase.login('salahnahed', '123');
    expect((sut.output as LoginServiceOutputSpy).receivedError, error);
  });
}
