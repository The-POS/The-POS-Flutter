import 'login_result.dart';

abstract class Login {
  Future<LoginResult> login(String username, String password);
}
