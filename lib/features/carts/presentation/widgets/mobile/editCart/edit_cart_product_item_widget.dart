import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditCartProductItemWidget extends StatelessWidget {
  const EditCartProductItemWidget({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productBarCode,
    required this.productPrice,
  }) : super(key: key);

  final String productImage;
  final String productName;
  final String productBarCode;
  final double productPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Image.network(productImage),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              productName,
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildProductDetailsRow(title: 'الباركود', value: productBarCode),
            _buildProductDetailsRow(
                title: 'السعر', value: '$productPrice ريال '),
          ],
        )
      ],
    );
  }

  Row _buildProductDetailsRow({required String title, required String value}) {
    return Row(
      children: <Widget>[
        Text(
          '$title :',
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
