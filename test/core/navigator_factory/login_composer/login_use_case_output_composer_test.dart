import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

import '../../../login/data/helpers/shared_test_helper.dart';
import '../../../login/presentation/helpers/shared_helpers.dart';

class LoginUseCaseOutputComposer extends LoginUseCaseOutput {
  LoginUseCaseOutputComposer(this.outputs);

  final List<LoginUseCaseOutput> outputs;
  @override
  void onLoginSuccess(LoginResult result) {
    for (final LoginUseCaseOutput output in outputs) {
      output.onLoginSuccess(result);
    }
  }
}

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
}

class LoginUseCaseOutputSpy extends LoginUseCaseOutput {
  List<LoginResult> loginSuccessCalls = <LoginResult>[];
  @override
  void onLoginSuccess(LoginResult result) {
    loginSuccessCalls.add(result);
  }
}
