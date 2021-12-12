import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);

  final SplashController controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}
