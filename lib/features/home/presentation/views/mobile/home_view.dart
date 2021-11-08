import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thepos/routes/mobile_app_pages.dart';

import '../../widgets/mobile/cart_floating_action_button.dart';
import '../../widgets/mobile/categories_widget.dart';
import '../../widgets/mobile/home_app_bar.dart';
import '../../widgets/mobile/products/products_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      floatingActionButton: CartFloatingActionButton(
        onPressed: _navigateToCartView,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: const <Widget>[
          CategoriesWidget(),
          Expanded(child: ProductsWidget())
        ],
      ),
    );
  }

  void _navigateToCartView() {
    Get.toNamed(MobileRoutes.CART);
  }
}
