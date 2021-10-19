import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
    const CategoryWidget({Key? key, required this.title, required this.isSelected}) : super(key: key);

  final String title;
  final bool isSelected;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected? Colors.transparent: Colors.grey,
                    style: BorderStyle.solid,
                    width: isSelected? 1:1.0,
                ),
                color: isSelected?const Color(0xff178F49) : Colors.white,
                borderRadius: BorderRadius.circular(8.0)),
      child: Text(title,style:  GoogleFonts.cairo(
        textStyle: TextStyle(color:isSelected?Colors.white: Colors.black,fontSize: 16),
      ),),
    );
  }
}
