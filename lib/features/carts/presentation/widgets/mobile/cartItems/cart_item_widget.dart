import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
    required this.isFirstItem,
    required this.quantity,
    required this.productName,
    required this.productPrice,
    required this.isLastItem,
    required this.onTap,
  }) : super(key: key);

  final int quantity;
  final String productName;
  final double productPrice;
  final bool isFirstItem;
  final bool isLastItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: _getBorderRadius(),
        ),
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'x$quantity',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              productName,
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _buildPriceRow(context),
          ],
        ),
      ),
    );
  }

  Row _buildPriceRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          '$productPrice',
          style: GoogleFonts.cairo(
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          'ريال',
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 8,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }

  BorderRadius? _getBorderRadius() {
    if (isFirstItem) {
      return const BorderRadius.vertical(top: Radius.circular(8));
    } else if (isLastItem) {
      return const BorderRadius.vertical(bottom: Radius.circular(8));
    } else {
      return null;
    }
  }
}
