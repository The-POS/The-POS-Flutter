// ignore: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/home/controllers/home_controller.dart';
import 'package:thepos/features/home/presentation/widgets/cart_widget.dart';
import 'package:thepos/features/home/presentation/widgets/category_widget.dart';
import 'package:thepos/features/home/presentation/widgets/header_home.dart';
import 'package:thepos/features/home/presentation/widgets/product_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
        backgroundColor: Color(0xffF4F5FA),
        body: Container(
          child: GetBuilder<HomeController>(
            builder: (cont) => Container(
              child: Row(
                children: [
                  if (!GetPlatform.isMobile)
                    Container(
                      width: 300,
                      color: Colors.white,
                      child: CartWidget(
                              controller: cont,
                            ),
                    ),
                  Expanded(
                    child: Container(
                      color: Colors.grey.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HeaderHomeWidget(controller: cont),
                          if (cont.showHideCarts.value && GetPlatform.isMobile)
                            Expanded(
                                child: CartWidget(
                              controller: cont,
                            )),
                          if (!(cont.showHideCarts.value &&
                              GetPlatform.isMobile))
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  // height: 40,
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children:
                                          cont.listCategory.map((category) {
                                        return GestureDetector(
                                            onTap: () {
                                              cont.changeCategory(category);
                                            },
                                            child: CategoryWidget(
                                                title: category.name,
                                                isSelected:
                                                    cont.selectedCategory != null &&
                                                        cont.selectedCategory!.id ==
                                                            category.id));
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          if (!(cont.showHideCarts.value &&
                              GetPlatform.isMobile))
                            Expanded(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children:
                                      cont.listHomeProduct.value.map((product) {
                                    return Container(
                                        width: 224,
                                        height: 239,
                                        child: ProductWidget(
                                          product: product,
                                        ));
                                  }).toList(),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
