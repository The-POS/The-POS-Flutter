import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSilverAppBar extends SliverAppBar {
  const HomeSilverAppBar({
    Key? key,
    required this.onSearchTextChanged,
    required this.onBarCodeButtonPressed,
  }) : super(key: key);

  final Function(String keyword) onSearchTextChanged;
  final VoidCallback onBarCodeButtonPressed;

  @override
  double? get expandedHeight => 150;

  @override
  bool get floating => true;

  @override
  bool get pinned => true;

  @override
  bool get centerTitle => true;

  @override
  Widget? get leading =>
      _buildElevatedButton('assets/svg/menu.svg', null, null);

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
      <Widget>[_buildElevatedButton('assets/svg/user.svg', null, null)];

  @override
  PreferredSizeWidget? get bottom => AppBar(
        toolbarHeight: 90,
        shape: shape,
        title: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildElevatedButton(
                    'assets/svg/barcode.svg', 24, onBarCodeButtonPressed),
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23.0),
                      color: Colors.white,
                    ),
                    child: TextField(
                      onChanged: (String value) => onSearchTextChanged(value),
                      decoration: const InputDecoration(
                        hintText: 'بحث',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  ShapeBorder? get shape => const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(23),
        ),
      );

  ElevatedButton _buildElevatedButton(
      String assets, double? size, VoidCallback? onBarCodeButtonPressed) {
    return ElevatedButton(
      onPressed: onBarCodeButtonPressed ?? () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: SvgPicture.asset(
        assets,
        width: size,
        height: size,
        color: Colors.white,
      ),
    );
  }
}
