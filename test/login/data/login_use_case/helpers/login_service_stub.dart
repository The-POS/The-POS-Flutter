import 'package:thepos/features/login/data/login_service/login_service.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

class LoginServiceStub extends LoginService {
  LoginServiceStub({this.result, this.error});

  final LoginResult? result;
  final Object? error;

  @override
  Future<LoginResult> login(String username, String password) {
    return error != null
        ? Future<LoginResult>.error(error!)
        : Future<LoginResult>.value(result);
  }
}
