import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/login_result.dart';
import 'package:thepos/features/login/data/login_use_case.dart';
import 'package:thepos/features/login/data/login_use_case_errors.dart';

import '../helpers/mock_client_stub.dart';
import '../invoice/helpers/shared_test_helper.dart';

class LoginUseCaseSUT {
  LoginUseCaseSUT(this.client, this.loginUseCase);

  final MockClientStub client;
  final LoginUseCase loginUseCase;
}

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
    final LoginUseCaseSUT sut = _makeSUT();

    sut.client.completeWith(anyException);

    final dynamic error = await tryFunction(
      () => sut.loginUseCase.login('salahnahed', '123'),
    );

    expect(error, LoginUseCaseErrors.connectivity);
  });

  test('login delivers invalidData error on non 200 HTTP Response', () async {
    final LoginUseCaseSUT sut = _makeSUT();
    final List<int> samples = <int>[199, 201, 300, 400, 500];
    for (final int statusCode in samples) {
      sut.client.completeWithResponse(
          MockClientStub.createResponse(statusCode, 'response'));
      final dynamic error = await tryFunction(
        () => sut.loginUseCase.login('salahnahed', '123'),
      );
      expect(error, LoginUseCaseErrors.invalidData);
    }
  });

  test('login delivers invalidCredential error on 401 HTTP Response', () async {
    final LoginUseCaseSUT sut = _makeSUT();
    sut.client
        .completeWithResponse(MockClientStub.createResponse(401, 'response'));
    final dynamic error = await tryFunction(
      () => sut.loginUseCase.login('salahnahed', '123'),
    );
    expect(error, LoginUseCaseErrors.invalidCredential);
  });

  test(
      'login delivers invalidData error on 200 HTTP Response with invalid json',
      () async {
    final LoginUseCaseSUT sut = _makeSUT();
    sut.client.completeWithResponse(
        MockClientStub.createResponse(200, 'invalid json'));
    final dynamic error = await tryFunction(
      () => sut.loginUseCase.login('salahnahed', '123'),
    );
    expect(error, LoginUseCaseErrors.invalidData);
  });

  test('login delivers login result 200 HTTP Response', () async {
    final LoginUseCaseSUT sut = _makeSUT();

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
    const String response =
        '{"token": "$anyToken","user": "$user","expire": $expire,"display_name": "$displayName"}';

    const String username = 'salahnahed';
    const String password = '123';

    sut.client
        .completeWithResponse(MockClientStub.createResponse(200, response));

    final LoginResult actualResult =
        await sut.loginUseCase.login(username, password);

    expect(actualResult.token, expectedResult.token);
    expect(actualResult.user, expectedResult.user);
    expect(actualResult.expire, expectedResult.expire);
    expect(actualResult.displayName, expectedResult.displayName);
  });
}
