import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class POSAppBar extends AppBar {
  POSAppBar({Key? key}) : super(key: key);

  @override
  Widget? get leading => _buildElevatedButton('assets/svg/menu.svg');

  @override
  Widget? get title => Text(
        'المبيعات',
        style: GoogleFonts.cairo(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  List<Widget>? get actions =>
      <Widget>[_buildElevatedButton('assets/svg/user.svg')];

  ElevatedButton _buildElevatedButton(String assets) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: SvgPicture.asset(assets),
    );
  }
}
