import 'package:thepos/features/login/data/login_service/login_service.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/presentation/controller/login_controller.dart';
import 'package:thepos/features/login/presentation/login_router.dart';

import '../auth_manager.dart';
import 'login_use_case_output_composer.dart';

class LoginUseCaseFactory {
  LoginUseCase makeUseCase(
      {required AuthManager authManager,
      required LoginController loginController,
      required LoginRouter loginRouter,
      required LoginService loginService}) {
    final LoginUseCase useCase = LoginUseCase(
      loginService: loginService,
      output: LoginUseCaseOutputComposer(<LoginUseCaseOutput>[
        loginController,
        authManager,
        loginRouter,
      ]),
    );
    return useCase;
  }
}
