import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/login_service/login_errors.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

import '../../../invoice/helpers/shared_test_helper.dart';
import '../api_login/helpers/api_login_service_sut.dart';

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
    required LoginErrors expectedError,
    required Function(ApiLoginServiceSUT sut) when}) async {
  when(sut);
  final dynamic actualError = await tryFunction(
    () => sut.apiLoginService.login('salahnahed', '123'),
  );
  expect(
    actualError,
    expectedError,
    reason: 'actual error $actualError does not'
        ' equal matcher error $expectedError',
  );
}

void expectLoginResult(LoginResult? actual, LoginResult? matcher) {
  expect(
    actual?.token,
    matcher?.token,
    reason: 'actual login result token ${actual?.token} does not'
        ' equal matcher login result token ${matcher?.token}',
  );
  expect(
    actual?.user,
    matcher?.user,
    reason: 'actual login result user ${actual?.user} does not'
        ' equal matcher login result user ${matcher?.user}',
  );
  expect(
    actual?.expire,
    matcher?.expire,
    reason: 'actual login result expire ${actual?.expire} does not'
        ' equal matcher login result expire ${matcher?.expire}',
  );
  expect(
    actual?.displayName,
    matcher?.displayName,
    reason: 'actual login result displayName ${actual?.displayName} does not'
        ' equal matcher login result displayName ${matcher?.displayName}',
  );
}
