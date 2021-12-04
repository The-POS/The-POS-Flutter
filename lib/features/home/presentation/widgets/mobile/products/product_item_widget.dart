import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/home/data/models/product.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    this.productSalePrice,required this.product,
  }) : super(key: key);

  final String productImage;
  final String productName;
  final double productPrice;
  final double? productSalePrice;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              productImage,
              width: 100,
              height: 100,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                Text(
                  productName,
                  style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    if (productSalePrice != null && productSalePrice! > 0)
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            productPrice.toStringAsFixed(2),
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'ريال',
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red,
                                fontSize: 9,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          productSalePrice != null && productSalePrice! > 0
                              ? '${productSalePrice?.toStringAsFixed(2)}'
                              : productPrice.toStringAsFixed(2),
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
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
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
