import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget(
      {Key? key, required this.title, required this.isSelected})
      : super(key: key);

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xffF79624)
              : Color(0xffF79624).withOpacity(0.4),
          borderRadius: BorderRadius.circular(8.0)),
      child: Text(
        title,
        style: GoogleFonts.cairo(
          textStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
