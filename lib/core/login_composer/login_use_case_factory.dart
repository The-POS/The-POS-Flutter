import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepos/core/navigator/navigator_factory.dart';
import 'package:thepos/features/login/data/login_service/login_service.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/presentation/controller/login_controller.dart';
import 'package:thepos/features/login/presentation/login_router.dart';

import '../auth_manager.dart';
import 'login_use_case_output_composer.dart';

class LoginUseCaseFactory {
  LoginUseCase makeUseCase(
      {required SharedPreferences sharedPreferences,
      required LoginController loginController,
      required NavigatorFactory navigatorFactory,
      required LoginService loginService}) {
    final AuthManager authManager = AuthManager(sharedPreferences);
    final LoginRouter router = LoginRouter(navigatorFactory);
    final LoginUseCase useCase = LoginUseCase(
      loginService: loginService,
      output: LoginUseCaseOutputComposer(<LoginUseCaseOutput>[
        loginController,
        authManager,
        router,
      ]),
    );
    return useCase;
  }
}
