import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:thepos/core/navigator/app_navigator_factory.dart';

import 'helpers.dart';

/// ideally we should decouple our tests from Get implementation,
///  maybe the better approach is to use navigatorObservers
///  instead of Get.previousRoute && Get.currentRoute
///  those tests are a fragile tests any change of Getx snackBar code may break tests
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

  testWidgets(
    'snackbar should show snackbar with specific message and title',
    (WidgetTester tester) async {
      await tester.pumpWidget(anyMaterialApp);

      expect(Get.currentRoute, AnyRoutes.ANY_ROUTE, reason: 'precondition');
      expect(Get.isSnackbarOpen, false, reason: 'precondition');

      final AppNavigatorFactory sut = AppNavigatorFactory();
      const String title = 'snackbar title';
      const String message = 'snackbar message';
      const Duration animationDuration = Duration(milliseconds: 50);
      sut.snackbar(
        title,
        message,
        animationDuration: animationDuration,
      );

      await tester.pump(animationDuration);

      expect(Get.isSnackbarOpen, true);
      expect(find.text(title), findsOneWidget);
      expect(find.text(message), findsOneWidget);

      Get.closeAllSnackbars(); // we need to call this to make test pass without throwing an error.
    },
  );
}
