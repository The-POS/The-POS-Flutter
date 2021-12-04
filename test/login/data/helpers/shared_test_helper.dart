import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/api_login/api_login_errors.dart';
import 'package:thepos/features/login/data/login_result.dart';

import '../../../invoice/helpers/shared_test_helper.dart';
import 'api_login_service_sut.dart';

Future<void> expectLoginToCompleteWithResult(
    {required ApiLoginServiceSUT sut,
    required LoginResult expectedResult,
    required Function(ApiLoginServiceSUT sut) when}) async {
  when(sut);
  final LoginResult actualResult =
      await sut.apiLoginService.login('salahnahed', '123');
  expectLoginResult(actualResult, expectedResult);
}

Future<void> expectLoginToCompleteWithError(
    {required ApiLoginServiceSUT sut,
    required ApiLoginErrors expectedError,
    required Function(ApiLoginServiceSUT sut) when}) async {
  when(sut);
  final dynamic actualError = await tryFunction(
    () => sut.apiLoginService.login('salahnahed', '123'),
  );
  expect(actualError, expectedError);
}

void expectLoginResult(LoginResult? result, LoginResult? otherResult) {
  expect(result?.token, otherResult?.token);
  expect(result?.user, otherResult?.user);
  expect(result?.expire, otherResult?.expire);
  expect(result?.displayName, otherResult?.displayName);
}
