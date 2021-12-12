import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetMaterialApp anyMaterialApp = GetMaterialApp(
  getPages: anyRoutes,
  initialRoute: AnyRoutes.ANY_ROUTE,
);

class AnyWidget extends StatelessWidget {
  const AnyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

final List<GetPage<Widget>> anyRoutes = <GetPage<Widget>>[
  GetPage<AnyWidget>(
    name: AnyRoutes.ANY_ROUTE,
    page: () => const AnyWidget(),
  ),
  GetPage<AnyWidget>(
    name: AnyRoutes.ANOTHER_ROUTE,
    page: () => const AnyWidget(),
  ),
];

abstract class AnyRoutes {
  static const String ANY_ROUTE = '/any_route';
  static const String ANOTHER_ROUTE = '/another_route';
}
