import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController(this.navigateToNextScreen);

  final VoidCallback navigateToNextScreen;

  @override
  void onReady() {
    super.onReady();
    Future<void>.delayed(const Duration(seconds: 2), navigateToNextScreen);
  }
}
