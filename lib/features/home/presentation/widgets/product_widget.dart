import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/product.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffDADADA),
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0)),
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              faker.image.loremPicsum.image(),
              width: 150,
              fit: BoxFit.contain,
            ),
          ),

          Divider(color: Color(0xffDADADA),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ريال",
                maxLines: 1,
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                product.price.toString(),
                maxLines: 1,
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  product.name,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
