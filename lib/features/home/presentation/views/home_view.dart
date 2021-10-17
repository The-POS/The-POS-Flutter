import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/home/controllers/home_controller.dart';
import 'package:thepos/features/home/presentation/widgets/category_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  // final selectCat = 0; //
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 300,
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 70,
                    color: Colors.white,
                  ),

                        Container(
                          height: 40,
                          child: SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: controller.listCat.map((value) {
                    return CategoryWidget(title: value, isSelected: true);
                  }).toList(),),
                          ),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
