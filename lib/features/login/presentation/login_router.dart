import 'package:thepos/core/navigator/navigator_factory.dart';
import 'package:thepos/routes/mobile_app_pages.dart';

import '../data/login_service/login_errors.dart';
import '../data/login_use_case/login_use_case_output.dart';
import '../data/models/login_result.dart';

class LoginRouter extends LoginUseCaseOutput {
  LoginRouter(this.navigatorFactory);

  final NavigatorFactory navigatorFactory;

  @override
  void onLoginSuccess(LoginResult result) {
    navigatorFactory.offAndToNamed(MobileRoutes.HOME);
  }

  @override
  void onLoginFail(LoginErrors error) {
    navigatorFactory.snackbar('error', error.toString());
  }
}
