import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/core/navigator/navigator_factory.dart';
import 'package:thepos/routes/mobile_app_pages.dart';

import '../helpers/navigator/navigator_factory_spy.dart';
import '../helpers/navigator/navigator_shared_helper.dart';

class SplashRouter {
  SplashRouter({required this.navigatorFactory, required this.isAuthenticated});

  final NavigatorFactory navigatorFactory;
  final bool isAuthenticated;
  void navigateToNextScreen() {
    if (isAuthenticated) {
    } else {
      navigatorFactory.offAndToNamed(MobileRoutes.LOGIN);
    }
  }
}

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
}
