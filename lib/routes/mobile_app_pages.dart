import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:thepos/features/home/presentation/views/mobile/home_view.dart';

const String MOBILE_INITIAL = MobileRoutes.HOME;

final List<GetPage<Widget>> mobileRoutes = <GetPage<Widget>>[
  GetPage<HomeView>(
    name: MobileRoutes.HOME,
    page: () => const HomeView(),
  ),
];

abstract class MobileRoutes {
  static const String HOME = '/mobile_home';
}
