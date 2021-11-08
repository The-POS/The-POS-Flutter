import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InvoiceFloatingActionButton extends FloatingActionButton {
  const InvoiceFloatingActionButton({Key? key, required VoidCallback onPressed})
      : super(key: key, onPressed: onPressed);

  @override
  Widget? get child => Container(
        padding: const EdgeInsets.all(16.0),
        width: 64,
        height: 64,
        child: SvgPicture.asset('assets/svg/dashboard.svg'),
      );
}
