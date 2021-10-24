import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';

class CartItemProductWidget extends StatelessWidget {
  final CartItem item;
  CartItemProductWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
