// ignore: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/carts/controllers/carts_controller.dart';
import 'package:thepos/features/carts/presentation/widgets/cart_item_widget.dart';

final cartsController = Get.put(CartsController());

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return 
    
      Obx(() => 
    Directionality(
      textDirection: TextDirection.rtl,
      child:Container(
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      // height: 100,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: cartsController.listCarts.map((cart) {
                return GestureDetector(
                    onTap: () {
                      cartsController.changeCart(cart);
                    },
                    child: CartItemWidget(
                        title: cart.keyCart,
                        isSelected: cartsController.selectedCart != null &&
                            cartsController.selectedCart.value == cart));
              }).toList(),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffF79624),
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                // color: const Color(0xff178F49) ,
                borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                   Text(
                  "زائر - ١٠٠",
                  style: GoogleFonts.cairo(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.account_circle_outlined,color:const Color(0xffF79624),size: 30  ,),
             
              ],
            ),
          )
        ],
      ),
    )));
  }
}
