import 'package:get/get.dart';

import 'navigator_factory.dart';

class AppNavigatorFactory extends NavigatorFactory {
  @override
  void offAndToNamed(String routeName) {
    Get.offAndToNamed(routeName);
  }

  @override
  void snackbar(String title, String message,
      {Duration animationDuration = const Duration(seconds: 1)}) {
    Get.snackbar(
      title,
      message,
      animationDuration: animationDuration,
    );
  }
}
