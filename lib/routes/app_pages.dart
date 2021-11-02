// ignore_for_file: always_specify_types

import 'package:get/get.dart';
// import 'package:thepos/features/home/presentation/views/home_binding.dart';
import 'package:thepos/features/home/presentation/views/home_view.dart';
import 'package:thepos/features/splash/presentation/views/splash_view.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
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
