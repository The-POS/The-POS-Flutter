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
  Widget? get child => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$numberOfOpenedCart',
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/svg/go_cart.svg',
            height: 24,
          ),
          const SizedBox(height: 6)
        ],
      );
}
