import 'package:get/get.dart';

import 'navigator_factory.dart';

class AppNavigatorFactory extends NavigatorFactory {
  @override
  void offAndToNamed(String routeName) {
    Get.offAndToNamed(routeName);
  }
}
