import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryWidget({Key? key, required this.title, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 1.0,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0)),
      child: Text(title,style:  GoogleFonts.cairo(
        textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 16),
      ),),
    );
  }
}
