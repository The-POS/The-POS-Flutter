import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/carts/data/models/customer.dart';
import 'package:thepos/features/carts/presentation/controllers/carts_controller.dart';
import 'package:thepos/features/carts/presentation/views/mobile/cart_list_view.dart';

import '../../widgets/mobile/cartItems/cart_items_widget.dart';
import '../../widgets/mobile/cart_app_bar.dart';
import '../../widgets/mobile/cart_list_floating_action_button.dart';
import '../../widgets/mobile/pay_button.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);

  final CartsController cartsController = Get.find<CartsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CartAppBar(),
        floatingActionButton: CartListFloatingActionButton(
          onPressed: _showCartListView,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: _buildBody(),
      ),
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _buildTopRow(),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffF79624),
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  // color: const Color(0xff178F49) ,
                  borderRadius: BorderRadius.circular(5.0)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Customer>(
                  key: cartsController.dropdownKey,
                  value: cartsController
                      .listCustomer[cartsController.selectedCustomer.value],
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Color(0xffF79624),
                    size: 30,
                  ),
                  isExpanded: true,
                  items: List.generate(
                      cartsController.listCustomer.length +1,
                      (index) => index < cartsController.listCustomer.length
                          ? DropdownMenuItem(
                          value: cartsController.listCustomer[index],
                          child: Text(cartsController
                              .listCustomer[index].mobile_no))
                          : DropdownMenuItem(
                        child: TextButton(
                          child: Text('...إضافة جديد',style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                              color: const Color(0xff178F49),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),),
                          onPressed: () {
                            cartsController.showDialogAddCustomer();
                          },
                        ),
                      )),
                  onChanged: (Customer? customer) {
                    if (customer != null)
                      cartsController.selectedCustomer.value =
                          cartsController.listCustomer.indexOf(customer);
                  },
                ),
              )),
          Expanded(
            child: CartItemsWidget(
              cart:
                  cartsController.listCarts[cartsController.selectedCart.value],
              onTapCartItem: (int index) => cartsController.editCartItem(index),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PayButton(
              isLoading: cartsController.isPayLoading.value,
              invoiceTotal: cartsController.invoiceTotal,
              onPressed: () => cartsController.pay(),
            ),
          ),
        ],
      ),
    );
  }

  void _showCartListView() {
    Get.defaultDialog(
      title: '',
      backgroundColor: Colors.white,
      barrierDismissible: true,
      radius: 5,
      content: Obx(
        () => CartListView(
          selectedCartIndex: cartsController.selectedCart.value,
          onSelectCart: (int selectIndex) {
            cartsController.changeCart(selectIndex);
            Get.back();
          },
        ),
      ),
    );
  }



  Widget _buildTopRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          _buildElevatedButton(
            assets: 'assets/svg/dots.svg',
            onPressed: () {},
          ),
          const Spacer(),
          _buildElevatedButton(
            assets: 'assets/svg/delete.svg',
            onPressed: () => cartsController.clearCarts(),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildElevatedButton(
      {required String assets, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: SvgPicture.asset(assets),
    );
  }
}
