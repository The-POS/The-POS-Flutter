// ignore_for_file: always_specify_types

import 'package:get/get.dart';
import 'package:thepos/features/carts/data/models/cart.dart';

class CartsController extends GetxController {
  var listCarts = <Cart>[
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
  var selectedCart = Cart(keyCart: "1", cartItems: []).obs;

  @override
  void onReady() {
    super.onReady();

    // getProduct();
  }

  Future changeCart(Cart cart) async {
    selectedCart.value = cart;
    update();
  }

  // Future showHidCart() async {
  //   showHideCarts.value = !showHideCarts.value;
  //   update();
  // }
}
