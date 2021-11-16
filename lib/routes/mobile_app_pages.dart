import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:thepos/features/carts/presentation/views/mobile/cart_view.dart';
import 'package:thepos/features/home/presentation/views/mobile/home_view.dart';

const String MOBILE_INITIAL = MobileRoutes.HOME;

final List<GetPage<Widget>> mobileRoutes = <GetPage<Widget>>[
  GetPage<HomeView>(
    name: MobileRoutes.HOME,
    page: () => HomeView(),
  ),
  GetPage<CartView>(
    name: MobileRoutes.CART,
    page: () => CartView(),
  ),
];

abstract class MobileRoutes {
  static const String HOME = '/mobile_home';
  static const String CART = '/mobile_cart';
}
