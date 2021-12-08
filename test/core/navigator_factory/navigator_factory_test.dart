import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:thepos/core/navigator/app_navigator_factory.dart';

import 'helpers.dart';

/// ideally we should decouple our tests from Get implementation,
///  maybe the better approach is to use navigatorObservers
///  instead of Get.previousRoute && Get.currentRoute **/
void main() {
  testWidgets(
    'offAndToNamed should pop the current widget and pushed the new one',
    (WidgetTester tester) async {
      await tester.pumpWidget(anyMaterialApp);

      expect(Get.currentRoute, AnyRoutes.ANY_ROUTE, reason: 'precondition');

      final AppNavigatorFactory sut = AppNavigatorFactory();
      sut.offAndToNamed(AnyRoutes.ANOTHER_ROUTE);

      expect(Get.previousRoute, '',
          reason: 'offAndToNamed should remove previousRoute from the stack');
      expect(Get.currentRoute, AnyRoutes.ANOTHER_ROUTE);
    },
  );
}
