import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/api_login/api_login_errors.dart';
import 'package:thepos/features/login/data/login_result.dart';

import '../../../invoice/helpers/shared_test_helper.dart';
import 'login_use_case_sut.dart';

Future<void> expectLoginToCompleteWithResult(
    {required LoginUseCaseSUT sut,
    required LoginResult expectedResult,
    required Function(LoginUseCaseSUT sut) when}) async {
  when(sut);
  final LoginResult actualResult =
      await sut.apiLoginService.login('salahnahed', '123');
  expectLoginResult(actualResult, expectedResult);
}

Future<void> expectLoginToCompleteWithError(
    {required LoginUseCaseSUT sut,
    required ApiLoginErrors expectedError,
    required Function(LoginUseCaseSUT sut) when}) async {
  when(sut);
  final dynamic actualError = await tryFunction(
    () => sut.apiLoginService.login('salahnahed', '123'),
  );
  expect(actualError, expectedError);
}

void expectLoginResult(LoginResult? result, LoginResult otherResult) {
  expect(result?.token, otherResult.token);
  expect(result?.user, otherResult.user);
  expect(result?.expire, otherResult.expire);
  expect(result?.displayName, otherResult.displayName);
}
