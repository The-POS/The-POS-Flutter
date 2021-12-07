import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

abstract class NavigatorFactory {
  void offAndToNamed(String routeName);
}

class AppNavigatorFactory extends NavigatorFactory {
  @override
  void offAndToNamed(String routeName) {
    Get.offAndToNamed(routeName);
  }
}

GetMaterialApp testableMaterialApp = GetMaterialApp(
  getPages: testRoutes,
  initialRoute: TestRoutes.ANY_ROUTE,
);
void main() {
  testWidgets(
    'offAndToNamed should pop the current widget and pushed the new one',
    (WidgetTester tester) async {
      await tester.pumpWidget(testableMaterialApp);

      expect(Get.currentRoute, TestRoutes.ANY_ROUTE, reason: 'precondition');

      final AppNavigatorFactory navigatorFactory = AppNavigatorFactory();
      navigatorFactory.offAndToNamed(TestRoutes.ANY_ROUTE);

      expect(Get.previousRoute, '',
          reason: 'offAndToNamed should remove previousRoute from the stack');
      expect(Get.currentRoute, TestRoutes.ANOTHER_ROUTE);
    },
  );
}

class AnyWidget extends StatelessWidget {
  const AnyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

final List<GetPage<Widget>> testRoutes = <GetPage<Widget>>[
  GetPage<AnyWidget>(
    name: TestRoutes.ANY_ROUTE,
    page: () => const AnyWidget(),
  ),
  GetPage<AnyWidget>(
    name: TestRoutes.ANOTHER_ROUTE,
    page: () => const AnyWidget(),
  ),
];

abstract class TestRoutes {
  static const String ANY_ROUTE = '/any_route';
  static const String ANOTHER_ROUTE = '/another_route';
}
