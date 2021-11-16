import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PayButton extends StatelessWidget {
  const PayButton({
    Key? key,
    required this.invoiceTotal,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  final double invoiceTotal;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff178f49), // background
        onPrimary: const Color(0xffF79624),
        fixedSize: Size(MediaQuery.of(context).size.width, 55),
        // foreground
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: 55,
              child: Row(
                children: <Widget>[
                  Text(
                    'الدفع',
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$invoiceTotal',
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'ريال',
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
