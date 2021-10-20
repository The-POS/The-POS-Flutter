import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/home/controllers/home_controller.dart';
import 'package:thepos/features/home/presentation/widgets/cart_item_widget.dart';

class CartWidget extends StatelessWidget {
  CartWidget({Key? key, required this.controller}) : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
              children: controller.listCarts.map((cart) {
                return GestureDetector(
                    onTap: () {
                      // controller.changeCategory(category);
                    },
                    child: CartItemWidget(
                        title: cart.toString(),
                        isSelected: controller.selectedCart != null &&
                            controller.selectedCart == cart.toString()));
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
    ));
  }
}
