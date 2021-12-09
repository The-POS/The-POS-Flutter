import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/login/data/login_service/login_errors.dart';
import 'package:thepos/features/login/presentation/login_router.dart';
import 'package:thepos/routes/mobile_app_pages.dart';

import '../../helpers/navigator/navigator_factory_spy.dart';
import '../../helpers/navigator/navigator_shared_helper.dart';
import 'helpers/shared_helpers.dart';

void main() {
  test('router should offAndToNamed to the home route on success login', () {
    final NavigatorFactorySpy navigatorFactory = NavigatorFactorySpy();
    final LoginRouter sut = LoginRouter(navigatorFactory);

    sut.onLoginSuccess(anyLoginResult);

    final Route expectedRoute =
        Route(type: NavigationType.offAndToNamed, name: MobileRoutes.HOME);

    expectRoutes(navigatorFactory.capturedRoutes, <Route>[expectedRoute]);
  });

  test('router should show snackbar with error message on failed to login', () {
    final NavigatorFactorySpy navigatorFactory = NavigatorFactorySpy();
    final LoginRouter sut = LoginRouter(navigatorFactory);

    final LoginErrors loginError = anyLoginError;
    sut.onLoginFail(loginError);

    final Route expectedRoute = Route(
        type: NavigationType.showSnackBar,
        details: 'error${loginError.toString()}');

    expectRoutes(navigatorFactory.capturedRoutes, <Route>[expectedRoute]);
  });
}
