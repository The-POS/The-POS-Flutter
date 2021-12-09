import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thepos/features/carts/presentation/controllers/carts_controller.dart';
import 'package:thepos/features/home/presentation/controllers/home_controller.dart';
import 'package:thepos/routes/mobile_app_pages.dart';

import '../../widgets/mobile/cart_floating_action_button.dart';
import '../../widgets/mobile/categories_widget.dart';
import '../../widgets/mobile/home_silver_app_bar.dart';
import '../../widgets/mobile/products/products_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final CartsController cartsController = Get.put(CartsController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController = Get.find<HomeController>();

    return Obx(
      () => Scaffold(
        floatingActionButton: CartFloatingActionButton(
          numberOfOpenedCart: cartsController.listCarts.length,
          onPressed: _navigateToCartView,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          slivers: <Widget>[
            HomeSilverAppBar(
              onSearchTextChanged: (String value) {
                homeController.onSearch(value);
              },
              onBarCodeButtonPressed: () {
                homeController.modalBottomSheetMenu4();
              },
            ),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  SliverList _buildBody() {
    return SliverList(
        delegate: SliverChildListDelegate(
      <Widget>[
        CategoriesWidget(
          categories: homeController.listCategory,
          selectedCategory: homeController.selectedCategory,
          selectCategory: homeController.changeCategory,
        ),
        if (homeController.loadingHome.value)
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else
          ProductsWidget(
            products: homeController.listHomeProduct,
            onTapProduct: cartsController.addProduct,
          )
      ],
    ));
  }

  void _navigateToCartView() {
    Get.toNamed(MobileRoutes.CART);
  }
}
