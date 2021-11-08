import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CartFloatingActionButton extends FloatingActionButton {
  const CartFloatingActionButton(
      {Key? key,
      required this.numberOfOpenedCart,
      required VoidCallback onPressed})
      : super(key: key, onPressed: onPressed);

  final int numberOfOpenedCart;

  @override
  Widget? get child => Container(
        margin: const EdgeInsets.all(8),
        width: 80,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '$numberOfOpenedCart',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 29,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SvgPicture.asset('assets/svg/go_cart.svg'),
          ],
        ),
      );
}
