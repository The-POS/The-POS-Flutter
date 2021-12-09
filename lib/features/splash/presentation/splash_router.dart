import 'package:thepos/core/navigator/navigator_factory.dart';
import 'package:thepos/routes/mobile_app_pages.dart';

class SplashRouter {
  SplashRouter({required this.navigatorFactory, required this.isAuthenticated});

  final NavigatorFactory navigatorFactory;
  final bool isAuthenticated;
  void navigateToNextScreen() {
    if (isAuthenticated) {
      navigatorFactory.offAndToNamed(MobileRoutes.HOME);
    } else {
      navigatorFactory.offAndToNamed(MobileRoutes.LOGIN);
    }
  }
}
