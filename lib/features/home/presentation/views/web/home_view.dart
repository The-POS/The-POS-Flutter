// ignore: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thepos/features/carts/presentation/controllers/carts_controller.dart';
import 'package:thepos/features/carts/presentation/views/web/cart_view.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/home/presentation/controllers/home_controller.dart';
import 'package:thepos/features/home/presentation/widgets/web/category_widget.dart';
import 'package:thepos/features/home/presentation/widgets/web/header_home.dart';
import 'package:thepos/features/home/presentation/widgets/web/product_widget.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final cartsController = Get.put(CartsController());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
        backgroundColor: const Color(0xffF4F5FA),
        body: GetBuilder<HomeController>(
          builder: (HomeController cont) => Row(
            children: [
              if (!GetPlatform.isMobile)
                Container(
                  width: 300,
                  color: Colors.white,
                  child: const CartView(),
                ),
              Expanded(
                child: Container(
                  color: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HeaderHomeWidget(controller: cont),
                      if (cont.showHideCarts.value && GetPlatform.isMobile)
                        const Expanded(child: CartView()),
                      if (!(cont.showHideCarts.value && GetPlatform.isMobile))
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: cont.listCategory.value.map((category) {
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
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      if (!(cont.showHideCarts.value && GetPlatform.isMobile))
                        Expanded(
                          child: SingleChildScrollView(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: cont.newListHomeProduct.value
                                  .map((Product product) {
                                return InkWell(
                                  onTap: () {
                                    cartsController.addProduct(product);
                                  },
                                  child: SizedBox(
                                      width: 224,
                                      height: 239,
                                      child: ProductWidget(
                                        product: product,
                                      )),
                                );
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
        ));
  }
}