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
            color: const Color(0xffDADADA),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              faker.image.loremPicsum.image(),
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
           if(!product.available!)
          Container(
            width: double.infinity,
            color: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              "نفذ من المخزون",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  if (product.salePrice != null && product.salePrice! > 0)
                    Row(
                      children: [
                        Text(
                          "ريال",
                          maxLines: 1,
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 10,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          product.price.toString(),
                          maxLines: 1,
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Text(
                        "ريال",
                        maxLines: 1,
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        product.salePrice != null && product.salePrice! > 0
                            ? '${product.salePrice?.toStringAsFixed(2)}'
                            : product.price.toStringAsFixed(2),
                        maxLines: 1,
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
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
