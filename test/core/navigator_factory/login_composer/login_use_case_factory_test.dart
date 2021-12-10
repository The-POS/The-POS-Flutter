import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepos/core/auth_manager.dart';
import 'package:thepos/core/config.dart';
import 'package:thepos/core/login_composer/login_use_case_output_composer.dart';
import 'package:thepos/core/navigator/navigator_factory.dart';
import 'package:thepos/features/login/data/login_service/api_login/api_login_service.dart';
import 'package:thepos/features/login/data/login_service/login_service.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case.dart';
import 'package:thepos/features/login/data/login_use_case/login_use_case_output.dart';
import 'package:thepos/features/login/presentation/controller/login_controller.dart';
import 'package:thepos/features/login/presentation/login_router.dart';

import '../../../helpers/navigator/navigator_factory_spy.dart';

class LoginUseCaseFactory {
  LoginUseCase makeUseCase(
      SharedPreferences sharedPreferences, NavigatorFactory navigatorFactory) {
    final Uri loginUri =
        Uri.https(domain, '/mocks/thepos/thepos:v2/8473374/api/v2/login');
    final LoginService loginService = ApiLoginService(http.Client(), loginUri);

    final LoginController loginController = Get.put(LoginController());
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

void main() {
  test('makeUseCase should compose correct outputs with correct order',
      () async {
    SharedPreferences.setMockInitialValues(<String, String>{});

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final LoginUseCaseFactory sut = LoginUseCaseFactory();
    final LoginUseCase useCase = sut.makeUseCase(
      sharedPreferences,
      NavigatorFactorySpy(),
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
