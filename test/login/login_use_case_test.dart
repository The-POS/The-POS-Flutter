import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../helpers/mock_client_stub.dart';

class LoginUseCase {
  LoginUseCase(this._client);

  final http.Client _client;

  void login() {}
}

void main() {
  LoginUseCase _makeSUT() {
    final MockClientStub client = MockClientStub();
    final LoginUseCase sut = LoginUseCase(client);
    return sut;
  }

  tearDown(() {
    MockClientStub.clear();
  });

  test('init does not post any data to the login end point', () {
    _makeSUT();
    expect(MockClientStub.requests.isEmpty, true);
  });
}
