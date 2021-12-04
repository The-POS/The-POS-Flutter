import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../helpers/mock_client_stub.dart';
import '../invoice/helpers/shared_test_helper.dart';

class LoginUseCaseSUT {
  LoginUseCaseSUT(this.client, this.loginUseCase);

  final MockClientStub client;
  final LoginUseCase loginUseCase;
}

class LoginUseCase {
  LoginUseCase(this._client, this._url);

  final http.Client _client;
  final Uri _url;

  Future login(String username, String password) async {
    try {
      final http.Response response = await _client.post(
        _url,
        body: json.encode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        return Future.error(LoginUseCaseErrors.invalidCredential);
      } else {
        return Future.error(LoginUseCaseErrors.invalidData);
      }
    } catch (error) {
      return Future.error(LoginUseCaseErrors.connectivity);
    }
  }
}

enum LoginUseCaseErrors { connectivity, invalidData, invalidCredential }

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
}
