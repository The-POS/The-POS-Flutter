import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thepos/features/home/presentation/controllers/home_controller.dart';


class Barcode extends StatelessWidget {
  HomeController controller;
  bool autoFocus;

  Barcode(this.controller,this.autoFocus);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus:autoFocus,
      onChanged: controller.onBarcode,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'أدخل الباركود الخاص بك',
        contentPadding: EdgeInsets.zero,
        prefix: Container(
          margin: const EdgeInsets.only(left: 5, top: 5),
          child: SvgPicture.asset(
            "assets/svg/barcode.svg",
            height: 20,
            width: 30,
            fit: BoxFit.fill,
          ),
        ),
        hintStyle: TextStyle(
          fontSize: 18,
          color: Colors.black.withOpacity(.7),
        ),
      ),
    );
  }
}

