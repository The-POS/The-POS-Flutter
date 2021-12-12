import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepos/core/auth_manager.dart';
import 'package:thepos/core/login_composer/login_use_case_factory.dart';
import 'package:thepos/core/login_composer/login_use_case_output_composer.dart';
import 'package:thepos/features/login/data/login_service/login_service.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/presentation/controller/login_controller.dart';
import 'package:thepos/features/login/presentation/login_router.dart';

import '../../../helpers/navigator/navigator_factory_spy.dart';
import 'helpers/dummy_login_service.dart';

void main() {
  test('makeUseCase should compose correct outputs with correct order',
      () async {
    SharedPreferences.setMockInitialValues(<String, String>{});

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final LoginService loginService = DummyLoginService();
    final LoginController loginController = LoginController();
    final LoginRouter loginRouter = LoginRouter(NavigatorFactorySpy());
    final AuthManager authManager = AuthManager(sharedPreferences);

    final LoginUseCaseFactory sut = LoginUseCaseFactory();
    final LoginUseCase useCase = sut.makeUseCase(
      authManager: authManager,
      loginRouter: loginRouter,
      loginController: loginController,
      loginService: loginService,
    );

    final LoginUseCaseOutput output = useCase.output;

    expect(output, isInstanceOf<LoginUseCaseOutputComposer>());

    final LoginUseCaseOutputComposer outputComposer =
        output as LoginUseCaseOutputComposer;
    expect(outputComposer.outputs.length, 3);
    expect(outputComposer.outputs[0], isInstanceOf<LoginController>());
    expect(outputComposer.outputs[1], isInstanceOf<AuthManager>());
    expect(outputComposer.outputs[2], isInstanceOf<LoginRouter>());
  });
}
