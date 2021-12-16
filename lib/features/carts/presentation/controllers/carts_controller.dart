// ignore_for_file: always_specify_types

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/core/config.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/carts/data/datasources/customer_remote_data_source.dart';
import 'package:thepos/features/carts/data/datasources/local_store_customer.dart';
import 'package:thepos/features/carts/data/datasources/remote_store_cutomer_error.dart';
import 'package:thepos/features/carts/data/datasources/store_customer.dart';
import 'package:thepos/features/carts/data/models/cart.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';
import 'package:thepos/features/carts/data/models/customer.dart';
import 'package:thepos/features/carts/presentation/views/mobile/edit_cart_item_view.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';
import 'package:thepos/features/invoice/helper/cart_invoice_mapper.dart';
import 'package:http/http.dart' as http;

class CartsController extends GetxController {
  RxList<Cart> listCarts = <Cart>[
    Cart(keyCart: "1", cartItems: []),
    Cart(keyCart: "2", cartItems: []),
    Cart(keyCart: "3", cartItems: []),
    Cart(keyCart: "4", cartItems: []),
    Cart(keyCart: "5", cartItems: []),
    Cart(keyCart: "6", cartItems: []),
    Cart(keyCart: "7", cartItems: []),
    Cart(keyCart: "8", cartItems: []),
    Cart(keyCart: "9", cartItems: []),
  ].obs;

  var selectedCart = 0.obs;
  var isPayLoading = false.obs;

  RxList<Customer> listCustomer = <Customer>[
    Customer(
        mobile_no: '1234567',
        name: "duaa",
        email: "duaabassam@gmail.com",
        ID: "233245"),
    Customer(
        mobile_no: '2345678',
        name: "israa",
        email: "israa@gmail.com",
        ID: "33333333"),
    Customer(
        mobile_no: '2222222',
        name: "aaaaa",
        email: "aaaaa@gmail.com",
        ID: "33333333"),
  ].obs;

  var selectedCustomer = 0.obs;
  GlobalKey dropdownKey = GlobalKey();
  var isCustomerLoading = false.obs;
  var errorValidateMessage = "".obs;

  double get invoiceTotal {
    final Cart selectedCard = listCarts.value[selectedCart.value];
    if (selectedCard.cartItems.isEmpty) {
      return 0.0;
    }
    return selectedCard.cartItems
        .map((e) => e.product.price * e.quantity)
        .reduce((value, element) => value + element);
  }

  @override
  void onReady() {
    super.onReady();
    // getProduct();
  }

  Future changeCart(int index) async {
    selectedCart.value = index;
    update();
  }

  Future addProduct(Product product) async {
    bool thereIsProductInCart = false;
    listCarts.value[selectedCart.value].cartItems.forEach((elementProduct) {
      if (elementProduct.product.sku == product.sku) {
        elementProduct.quantity = elementProduct.quantity + 1;
        thereIsProductInCart = true;
      }
    });

    if (!thereIsProductInCart) {
      listCarts.value[selectedCart.value].cartItems
          .add(CartItem(product: product, quantity: 1));
    }

    Get.snackbar("تم", "اضافة المنتج للسلة",
        backgroundColor: const Color(0xff178F49).withOpacity(0.5),
        snackPosition: SnackPosition.BOTTOM);
    update();
  }

  Future updateItem(CartItem product) async {
    listCarts.value[selectedCart.value].cartItems.forEach((elementProduct) {
      if (elementProduct.product.sku == product.product.sku) {
        elementProduct.quantity = product.quantity;
        elementProduct.product.price = product.product.price;
      }
    });
    update();
  }

  Future deleteItem(CartItem product) async {
    listCarts.value[selectedCart.value].cartItems.removeWhere(
            (elementProduct) =>
        elementProduct.product.sku == product.product.sku);

    update();
  }

  Future<void> pay() async {
    final cart = listCarts.value[selectedCart.value];
    final invoice = CartInvoiceMapper.createInvoiceFrom(cart: cart);
    isPayLoading.value = true;
    if (invoice != null) {
      final StoreInvoice invoiceRepository = getIt<StoreInvoice>();
      try {
        await invoiceRepository.store(invoice);
        Get.snackbar("تم", "تم إصدار الفاتورة",
            backgroundColor: const Color(0xff178F49).withOpacity(0.5),
            snackPosition: SnackPosition.BOTTOM);
        isPayLoading.value = false;
      } catch (error) {
        isPayLoading.value = false;
      }
    }
  }

  Future clearCarts() async {
    await Get.defaultDialog(
        title: "حذف ؟ ",
        titleStyle: GoogleFonts.cairo(
          textStyle: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "هل انت متأكد من حذف جميع العناصر في السلة  -  ${listCarts
                .value[selectedCart.value].keyCart}",
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        confirm: GestureDetector(
          onTap: () {
            final Cart tmpCart = listCarts[selectedCart.value];
            tmpCart.cartItems.clear();
            listCarts[selectedCart.value] = tmpCart;
            Get.back();
            update();
          },
          child: Text(
            "متابعة",
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        cancel: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(
              "الغاء",
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
            )));
  }

  void editCartItem(int index) {
    final CartItem cartItem = listCarts[selectedCart.value].cartItems[index];
    Get.bottomSheet(
      SizedBox(
        height: 900,
        child: EditCartItemView(
          quantity: cartItem.quantity,
          productImage: faker.image.loremPicsum.image(),
          productName: cartItem.product.name,
          productBarCode: cartItem.product.sku,
          productPrice: cartItem.product.price,
          updatePrice: (double price) async {
            cartItem.product.price = price;
            final tempCart = listCarts[selectedCart.value];
            tempCart.cartItems[index] = cartItem;
            listCarts[selectedCart.value] = tempCart;
            update();
            Get.back();
          },
          updateQuantity: (int quantity) async {
            cartItem.quantity = quantity;
            final tempCart = listCarts[selectedCart.value];
            tempCart.cartItems[index] = cartItem;
            listCarts[selectedCart.value] = tempCart;
            update();
            Get.back();
          },
        ),
      ),
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  void showDialogAddCustomer() {
    Navigator.pop(dropdownKey.currentContext!);
    final TextEditingController textNameEditingController =
    TextEditingController();
    final TextEditingController textEmailEditingController =
    TextEditingController();
    final TextEditingController textIDEditingController =
    TextEditingController();
    final TextEditingController textMobileNuEditingController =
    TextEditingController();

    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 110, vertical: 10),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      title: 'اضافة عميل جديد',
      titleStyle: GoogleFonts.cairo(
        textStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      barrierDismissible: true,
      radius: 5,
      content: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.right,
            controller: textIDEditingController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'رقم المعرف',
                labelStyle: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    color: const Color(0xff178F49),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            textAlign: TextAlign.right,
            controller: textNameEditingController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'اسم العميل',
                labelStyle: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    color: const Color(0xff178F49),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
          SizedBox(
            height: 5,
          ),
          Obx(() =>
              TextField(
                textAlign: TextAlign.right,
                controller: textMobileNuEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '*رقم الجوال',
                  labelStyle: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      color: const Color(0xff178F49),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // textMobileNuEditingController.value.text!=null? errorText: 'ffff':
                  alignLabelWithHint: true,
                  errorStyle: errorValidateMessage.value.isEmpty
                      ? null
                      : GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  errorText: errorValidateMessage.value.isEmpty
                      ? null
                      : errorValidateMessage.value,
                ),
                onChanged: (value) {
                  errorValidateMessage.value = validateInput(value)!;
                },
              )),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            textAlign: TextAlign.right,
            controller: textEmailEditingController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'الايميل',
                labelStyle: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    color: const Color(0xff178F49),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
          SizedBox(
            height: 8,
          ),
          Obx(() =>
              Container(
                  height: 50,
                  color: Color(0xff178F49),
                  width: double.infinity,
                  child: isCustomerLoading.value
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : Obx(() =>
                      _buildElevatedButton(
                        onPressed: () =>
                        textMobileNuEditingController.value.text.isNotEmpty
                            ? addCustomer(
                            textMobileNuEditingController.value.text,
                            textNameEditingController.value.text,
                            textIDEditingController.value.text,
                            textEmailEditingController.value.text)
                            : errorValidateMessage.value = validateInput(
                            textMobileNuEditingController.value.text)!,
                      ))
              )),
        ],
      ),
    );
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return '  أضف رقم الجوال   ';
    }
    return "";
  }

  ElevatedButton _buildElevatedButton({required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: errorValidateMessage.value.isEmpty ?
        const Color(0xff178f49):
        const Color(0xff178f49),
        shadowColor: Colors.transparent,
      ),
      child: Text( "حفظ",
         style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
         ),
    );
  }

  Future<void> addCustomer(String mobile, String name, String ID,
      String email) async {

    isCustomerLoading.value = true;
    var customer =
    Customer(mobile_no: mobile, name: name, ID: ID, email: email);

    if (customer != null) {
      final StoreCustomer storeCustomer = getIt<StoreCustomer>();
      try {
        await storeCustomer.store(customer);
        isCustomerLoading.value = false;
        Get.back();
        Get.snackbar("تم", "تم حفظ العميل الجديد",
            backgroundColor: const Color(0xff178F49).withOpacity(0.5),
            snackPosition: SnackPosition.BOTTOM);
      } catch (error) {
        isCustomerLoading.value = false;
        Get.snackbar("خطأ", "$error",
            backgroundColor: const Color(0xffec383d).withOpacity(0.5),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

}
