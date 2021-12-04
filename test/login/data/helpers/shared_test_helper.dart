import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/login_api/login_result.dart';
import 'package:thepos/features/login/data/login_api/login_use_case_errors.dart';

import '../../../invoice/helpers/shared_test_helper.dart';
import 'login_use_case_sut.dart';

Future<void> expectLoginToCompleteWithResult(
    {required LoginUseCaseSUT sut,
    required LoginResult expectedResult,
    required Function(LoginUseCaseSUT sut) when}) async {
  when(sut);
  final LoginResult actualResult =
      await sut.loginUseCase.login('salahnahed', '123');
  expectLoginResult(actualResult, expectedResult);
}

Future<void> expectLoginToCompleteWithError(
    {required LoginUseCaseSUT sut,
    required LoginUseCaseErrors expectedError,
    required Function(LoginUseCaseSUT sut) when}) async {
  when(sut);
  final dynamic actualError = await tryFunction(
    () => sut.loginUseCase.login('salahnahed', '123'),
  );
  expect(actualError, expectedError);
}

void expectLoginResult(LoginResult result, LoginResult otherResult) {
  expect(result.token, otherResult.token);
  expect(result.user, otherResult.user);
  expect(result.expire, otherResult.expire);
  expect(result.displayName, otherResult.displayName);
}
