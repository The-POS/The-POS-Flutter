// ignore: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/home/controllers/home_controller.dart';
import 'package:thepos/features/home/presentation/widgets/category_widget.dart';
import 'package:thepos/features/home/presentation/widgets/product_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Color(0xffF4F5FA),
      body: Row(
        children: [
          if (!GetPlatform.isMobile)
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
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0.2,
                      title: Text(
                        "المبيعات",
                        style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      leading: Container(
                        color: Color(0xffF79624),
                        width: 50,
                        child: Icon(Icons.menu),
                      ),
                      actions: [
                        Icon(
                          Icons.qr_code,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<HomeController>(
                    builder: (cont) => Container(
                      // height: 40,
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: cont.listCategory.map((category) {
                            return GestureDetector(
                                onTap: () {
                                  cont.changeCategory(category);
                                },
                                child: CategoryWidget(
                                    title: category.name,
                                    isSelected: cont.selectedCat != null &&
                                        cont.selectedCat!.id == category.id));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<HomeController>(
                      builder: (cont) => Expanded(
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
                          ))

                  //          Expanded(
                  //            child: GridView.builder(
                  //     itemCount: controller.listHomeProduct.value.length,
                  //     // shrinkWrap: true,
                  //     // physics: NeverScrollableScrollPhysics(),
                  //     scrollDirection: Axis.vertical,

                  //     itemBuilder: (BuildContext ctxt, int index) {
                  //       return InkWell(child: ProductWidget(product: controller.listHomeProduct.value[index],),);},  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // crossAxisCount: (GetPlatform.isMobile) ? 2 : 3),),
                  //          )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
