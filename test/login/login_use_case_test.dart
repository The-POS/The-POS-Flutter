import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../helpers/mock_client_stub.dart';
import '../invoice/helpers/shared_test_helper.dart';

class LoginUseCase {
  LoginUseCase(this._client, this._url);

  final http.Client _client;
  final Uri _url;

  Future login(String username, String password) async {
    await _client.post(
      _url,
      body: json.encode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    return Future.value('');
  }
}

void main() {
  LoginUseCase _makeSUT() {
    final MockClientStub client = MockClientStub();
    final LoginUseCase sut = LoginUseCase(
      client,
      Uri.http('domain', 'path'),
    );
    return sut;
  }

  tearDown(() {
    MockClientStub.clear();
  });

  test('init does not post any data to the login end point', () {
    _makeSUT();
    expect(MockClientStub.requests.isEmpty, true);
  });

  test('login post the correct data to the login end point', () async {
    final LoginUseCase sut = _makeSUT();

    const String username = 'salahnahed';
    const String password = '123';

    await tryFunction(() => sut.login(username, password));

    expect(
        MockClientStub.requests.first.body,
        json.encode(<String, String>{
          'username': username,
          'password': password,
        }));
  });
}
