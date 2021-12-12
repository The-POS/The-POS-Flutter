import '../models/login_result.dart';

abstract class LoginService {
  Future<LoginResult> login(String username, String password);
}
