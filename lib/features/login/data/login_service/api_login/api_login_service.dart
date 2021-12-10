import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thepos/features/login/data/login_service/login_errors.dart';

import '../../models/login_result.dart';
import '../login_service.dart';

class ApiLoginService extends LoginService {
  ApiLoginService(this._client, this._url);

  final http.Client _client;
  final Uri _url;

  @override
  Future<LoginResult> login(String username, String password) async {
    try {
      final http.Response response = await _client.post(
        _url,
        body: json.encode(<String, String>{
          'username': username,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
      );
      if (response.statusCode == 200) {
        return _tryParse(response.body);
      } else if (response.statusCode == 401) {
        return Future<LoginResult>.error(LoginErrors.invalidCredential);
      } else {
        return Future<LoginResult>.error(LoginErrors.invalidData);
      }
    } catch (error) {
      return Future<LoginResult>.error(LoginErrors.connectivity);
    }
  }

  Future<LoginResult> _tryParse(String body) {
    try {
      return Future<LoginResult>.value(LoginResult.fromJson(jsonDecode(body)));
    } catch (error) {
      return Future<LoginResult>.error(LoginErrors.invalidData);
    }
  }
}
