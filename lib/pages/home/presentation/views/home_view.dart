import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thepos/pages/home/presentation/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: Container(
              color: Colors.blue,
            ),
          );
        });
  }

}
