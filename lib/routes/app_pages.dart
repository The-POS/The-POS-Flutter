import 'package:get/get.dart';
import 'package:thepos/features/home/presentation/views/home_view.dart';
import 'package:thepos/features/splash/presentation/views/splash_view.dart';

part 'app_routes.dart';


class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage<void>(
        name: Routes.SPLASH,
        page: () => SplashView(),

          ),
    GetPage<void>(
        name: Routes.HOME,
        // ignore: avoid_dynamic_calls
        page: () => HomeView(),
          ),

        ];

}