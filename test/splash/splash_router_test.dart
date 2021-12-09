import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/splash/presentation/splash_router.dart';
import 'package:thepos/routes/mobile_app_pages.dart';

import '../helpers/navigator/navigator_factory_spy.dart';
import '../helpers/navigator/navigator_shared_helper.dart';

void main() {
  test(
      'navigateToNextScreen should navigate to login view when isAuthenticated false',
      () {
    const bool isAuthenticated = false;
    final NavigatorFactorySpy navigatorFactory = NavigatorFactorySpy();
    final SplashRouter sut = SplashRouter(
      navigatorFactory: navigatorFactory,
      isAuthenticated: isAuthenticated,
    );

    sut.navigateToNextScreen();

    final Route expectedRoute =
        Route(type: NavigationType.offAndToNamed, name: MobileRoutes.LOGIN);

    expectRoutes(navigatorFactory.capturedRoutes, <Route>[expectedRoute]);
  });
  test(
      'navigateToNextScreen should navigate to home view when isAuthenticated true',
      () {
    const bool isAuthenticated = true;
    final NavigatorFactorySpy navigatorFactory = NavigatorFactorySpy();
    final SplashRouter sut = SplashRouter(
      navigatorFactory: navigatorFactory,
      isAuthenticated: isAuthenticated,
    );

    sut.navigateToNextScreen();

    final Route expectedRoute =
        Route(type: NavigationType.offAndToNamed, name: MobileRoutes.HOME);

    expectRoutes(navigatorFactory.capturedRoutes, <Route>[expectedRoute]);
  });
}
