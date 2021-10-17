import 'package:get/get.dart';
import 'package:thepos/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    print("On Ready");
    gotoHome();
  }

  gotoHome() async {
    await Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(Routes.HOME);
    });
  }
}
