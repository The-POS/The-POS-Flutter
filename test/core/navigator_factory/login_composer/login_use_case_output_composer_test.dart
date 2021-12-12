import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/core/login_composer/login_use_case_output_composer.dart';
import 'package:thepos/features/login/data/login_service/login_errors.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

import '../../../login/data/helpers/shared_test_helper.dart';
import '../../../login/presentation/helpers/shared_helpers.dart';
import 'helpers/login_use_case_output_spy.dart';

void main() {
  test('compose multiple outputs should delegate success message', () {
    final LoginUseCaseOutputSpy output1 = LoginUseCaseOutputSpy();
    final LoginUseCaseOutputSpy output2 = LoginUseCaseOutputSpy();
    final LoginUseCaseOutputComposer sut =
        LoginUseCaseOutputComposer(<LoginUseCaseOutput>[
      output1,
      output2,
    ]);

    final LoginResult loginResult = anyLoginResult;
    sut.onLoginSuccess(loginResult);

    expect(output1.loginSuccessCalls.length, 1);
    for (final LoginResult element in output1.loginSuccessCalls) {
      expectLoginResult(element, loginResult);
    }
    expect(output2.loginSuccessCalls.length, 1);
    for (final LoginResult element in output2.loginSuccessCalls) {
      expectLoginResult(element, loginResult);
    }
  });

  test('compose multiple outputs should delegate failed message', () {
    final LoginUseCaseOutputSpy output1 = LoginUseCaseOutputSpy();
    final LoginUseCaseOutputSpy output2 = LoginUseCaseOutputSpy();
    final LoginUseCaseOutputComposer sut =
        LoginUseCaseOutputComposer(<LoginUseCaseOutput>[
      output1,
      output2,
    ]);

    final LoginErrors loginError = anyLoginError;
    sut.onLoginFail(loginError);

    expect(output1.loginFailedCalls.length, 1);
    for (final LoginErrors element in output1.loginFailedCalls) {
      expect(element, loginError);
    }
    expect(output2.loginFailedCalls.length, 1);
    for (final LoginErrors element in output2.loginFailedCalls) {
      expect(element, loginError);
    }
  });
}
