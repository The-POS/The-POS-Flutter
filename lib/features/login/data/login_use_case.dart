import 'dart:convert';

import 'package:http/http.dart' as http;

import 'login_result.dart';
import 'login_use_case_errors.dart';

class LoginUseCase {
  LoginUseCase(this._client, this._url);

  final http.Client _client;
  final Uri _url;

  Future<LoginResult> login(String username, String password) async {
    try {
      final http.Response response = await _client.post(
        _url,
        body: json.encode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        return _tryParse(response.body);
      } else if (response.statusCode == 401) {
        return Future<LoginResult>.error(LoginUseCaseErrors.invalidCredential);
      } else {
        return Future<LoginResult>.error(LoginUseCaseErrors.invalidData);
      }
    } catch (error) {
      return Future<LoginResult>.error(LoginUseCaseErrors.connectivity);
    }
  }

  Future<LoginResult> _tryParse(String body) {
    try {
      return Future<LoginResult>.value(LoginResult.fromJson(jsonDecode(body)));
    } catch (error) {
      return Future<LoginResult>.error(LoginUseCaseErrors.invalidData);
    }
  }
}
