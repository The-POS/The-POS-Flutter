import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:thepos/features/home/presentation/views/web/home_view.dart';
import 'package:thepos/features/splash/presentation/views/splash_view.dart';

const String WEB_INITIAL = WebRoutes.HOME;

final List<GetPage<Widget>> webRoutes = <GetPage<Widget>>[
  GetPage<SplashView>(
    name: WebRoutes.SPLASH,
    page: () => const SplashView(),
  ),
  GetPage<HomeView>(
    name: WebRoutes.HOME,
    page: () => HomeView(),
  ),
];

abstract class WebRoutes {
  static const String HOME = '/home';
  static const String SPLASH = '/splash';
}
