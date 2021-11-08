import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  CategoriesWidgetState createState() => CategoriesWidgetState();
}

class CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: <Widget>[
          _builderCategoryItem(context, 'الكل', true),
          _builderCategoryItem(context, 'الكلاب', false),
          _builderCategoryItem(context, 'القطط', false),
          _builderCategoryItem(context, 'الطيور', false),
          _builderCategoryItem(context, '+ الوصول السريع', false),
        ],
      ),
    );
  }

  Widget _builderCategoryItem(
      BuildContext context, String categoryName, bool selected) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Text(
        categoryName,
        style: GoogleFonts.cairo(
          textStyle: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
