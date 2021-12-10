import 'package:thepos/features/login/data/login_service/login_service.dart';
import 'package:thepos/features/login/data/models/login_result.dart';

import '../../../../login/presentation/helpers/shared_helpers.dart';

class DummyLoginService extends LoginService {
  @override
  Future<LoginResult> login(String username, String password) {
    return Future<LoginResult>.value(anyLoginResult);
  }
}
