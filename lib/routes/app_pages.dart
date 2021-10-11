import 'package:get/get.dart';
import 'package:thepos/pages/home/presentation/views/home_view.dart';
import 'package:thepos/pages/splash/presentation/views/splash_view.dart';
part 'app_routes.dart';


class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashView(),

          ),
    GetPage(
        name: Routes.HOME,
        page: () => HomeView(),
          ),

        ];

}