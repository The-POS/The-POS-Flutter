import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/home/presentation/controllers/home_controller.dart';

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: Text(
          "المبيعات",
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
        ),
        leading: InkWell(
          onTap: () {
            controller.showHidCart();
          },
          child: Container(
            color: const Color(0xffF79624),
            width: 50,
            child: const Icon(Icons.menu),
          ),
        ),
        actions: const [
          Icon(
            Icons.qr_code,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.search,
            color: Colors.grey,
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
