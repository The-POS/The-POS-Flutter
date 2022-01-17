import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/customer/data/models/customer.dart';
import 'package:thepos/features/carts/presentation/controllers/carts_controller.dart';
import 'package:thepos/features/carts/presentation/views/mobile/cart_list_view.dart';
import 'package:thepos/features/customer/presentation/controllers/customer_controller.dart';
import 'package:thepos/features/customer/presentation/widgets/model/item_dropdown_list.dart';

import '../../widgets/mobile/cartItems/cart_items_widget.dart';
import '../../widgets/mobile/cart_app_bar.dart';
import '../../widgets/mobile/cart_list_floating_action_button.dart';
import '../../widgets/mobile/pay_button.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);

  final CartsController cartsController = Get.find<CartsController>();
  final CustomerController customerController = Get.put(CustomerController());

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
            child: DropdownSearch<DropListItem>(
              //mode of dropdown
              mode: Mode.MENU,
              //to show search box
              showSearchBox: true,
              isFilteredOnline: true,
              onFind: (String? value) => customerController.onSearch(value!),
              showSelectedItems: true,
              dropDownButton: const Icon(
                Icons.account_circle_outlined,
                color: Color(0xffF79624),
                size: 30,
              ),
              //list of dropdown items
              onChanged: (DropListItem? customer) {
                if (customer != null) {
                  if (customer.isFooter())
                    customerController.showDialogAddCustomer();
                  else
                    cartsController.setSelectedCustomer(customer);
                }
              },
              //show selected item
              selectedItem: cartsController.listCarts[cartsController.selectedCart.value].customer,

              hint: "... اختر العميل",
              dropdownSearchDecoration: const InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero),
              compareFn: (item, selectedItem) {
                return item != null &&
                    selectedItem != null &&
                    (item == selectedItem);
              },
              popupItemBuilder: _customPopupItemBuilder,
              dropdownBuilder: _customDropDown,
            ),
          ),
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

  Widget _customDropDown(BuildContext context, DropListItem? item) {
    if (item == null || item.isFooter()) {
      return Container(
        child: Text(
          "... اختر العميل",
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              color: Color(0xff3e4040),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    return Container(
      child: Text(item.getCustomer()!.mobile_no),
    );
  }

  Widget _customPopupItemBuilder(BuildContext context, DropListItem? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: item!.isFooter()
          ? Text(
              '...إضافة جديد',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                    color: const Color(0xff178F49),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            )
          : ListTile(
              selected: isSelected,
              title: Text(item.getCustomer()!.mobile_no),
            ),
    );
  }
}
