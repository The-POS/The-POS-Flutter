import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';
import 'package:thepos/features/carts/presentation/views/edit_cart.dart';

class CartItemProductWidget extends StatelessWidget {
  final CartItem item;
  final Function refresh;
  CartItemProductWidget({Key? key, required this.item, required this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () async {
          if (GetPlatform.isMobile) {
            



            await Get.bottomSheet(
                EditCartWidget(
                  item: item,
                ),
                isScrollControlled: true,
                backgroundColor: Colors.white);
          } else {
            await Get.dialog(
              Material(
                child: EditCartWidget(
                  item: item,
                ),
              ),
            );
          }
          refresh();
        },
        leading: Text(
          "X ${item.quantity}",
          style: GoogleFonts.cairo(
            textStyle: TextStyle(
                color: Color(0xff000000),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        trailing: RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: "${item.quantity * item.product.price}",
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    color: Color(0xff178F49),
                    fontSize: 27,
                    fontWeight: FontWeight.w600),
              ),
            ),
            TextSpan(
              text: "ريال",
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        )),
        title: Text(
          "${item.product.name}",
          style: GoogleFonts.cairo(
            textStyle: TextStyle(
                color: Color(0xff000000),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}
