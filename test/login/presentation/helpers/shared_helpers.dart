import 'package:thepos/features/login/data/login_service/login_errors.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

final LoginResult anyLoginResult = LoginResult(
  token: 'token',
  user: 'user',
  expire: 0,
  displayName: 'displayName',
);

const LoginErrors anyLoginError = LoginErrors.connectivity;
