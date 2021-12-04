import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/login_result.dart';
import 'package:thepos/features/login/data/login_use_case.dart';
import 'package:thepos/features/login/data/login_use_case_errors.dart';

import '../../helpers/mock_client_stub.dart';
import '../../invoice/helpers/shared_test_helper.dart';
import 'helpers/login_use_case_sut.dart';
import 'helpers/shared_test_helper.dart';

void main() {
  LoginUseCaseSUT _makeSUT() {
    final MockClientStub client = MockClientStub();
    final LoginUseCase sut = LoginUseCase(
      client,
      Uri.http('domain', 'path'),
    );
    return LoginUseCaseSUT(client, sut);
  }

  tearDown(() {
    MockClientStub.clear();
  });

  test('init does not post any data to the login end point', () {
    _makeSUT();
    expect(MockClientStub.requests.isEmpty, true);
  });

  test('login post the correct data to the login end point', () async {
    final LoginUseCaseSUT sut = _makeSUT();

    const String username = 'salahnahed';
    const String password = '123';

    await tryFunction(() => sut.loginUseCase.login(username, password));

    expect(
        MockClientStub.requests.first.body,
        json.encode(<String, String>{
          'username': username,
          'password': password,
        }));
  });

  test('login delivers error on the client error', () async {
    await expectLoginToCompleteWithError(
      sut: _makeSUT(),
      when: (LoginUseCaseSUT sut) {
        sut.client.completeWith(anyException);
      },
      expectedError: LoginUseCaseErrors.connectivity,
    );
  });

  test('login delivers invalidData error on non 200 HTTP Response', () async {
    final List<int> samples = <int>[199, 201, 300, 400, 500];
    for (final int statusCode in samples) {
      await expectLoginToCompleteWithError(
        sut: _makeSUT(),
        when: (LoginUseCaseSUT sut) {
          sut.client.completeWithResponse(
              MockClientStub.createResponse(statusCode, 'response'));
        },
        expectedError: LoginUseCaseErrors.invalidData,
      );
    }
  });

  test('login delivers invalidCredential error on 401 HTTP Response', () async {
    await expectLoginToCompleteWithError(
      sut: _makeSUT(),
      when: (LoginUseCaseSUT sut) {
        sut.client.completeWithResponse(
            MockClientStub.createResponse(401, 'response'));
      },
      expectedError: LoginUseCaseErrors.invalidCredential,
    );
  });

  test(
      'login delivers invalidData error on 200 HTTP Response with invalid json',
      () async {
    await expectLoginToCompleteWithError(
      sut: _makeSUT(),
      when: (LoginUseCaseSUT sut) {
        sut.client.completeWithResponse(
            MockClientStub.createResponse(200, 'invalid json'));
      },
      expectedError: LoginUseCaseErrors.invalidData,
    );
  });

  test('login delivers login result 200 HTTP Response', () async {
    const String anyToken = 'token';
    const String user = 'alaadiaa';
    const int expire = 1640366209;
    const String displayName = 'Alaa Alsalehi';

    final LoginResult expectedResult = LoginResult(
      token: anyToken,
      user: user,
      expire: expire,
      displayName: displayName,
    );

    await expectLoginToCompleteWithResult(
      sut: _makeSUT(),
      expectedResult: expectedResult,
      when: (LoginUseCaseSUT sut) {
        const String response =
            '{"token": "$anyToken","user": "$user","expire": $expire,"display_name": "$displayName"}';
        sut.client
            .completeWithResponse(MockClientStub.createResponse(200, response));
      },
    );
  });
}
