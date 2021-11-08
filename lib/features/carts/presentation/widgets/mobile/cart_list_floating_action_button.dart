import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CartListFloatingActionButton extends FloatingActionButton {
  const CartListFloatingActionButton(
      {Key? key, required VoidCallback onPressed})
      : super(key: key, onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 64),
      child: super.build(context),
    );
  }

  @override
  Widget? get child => Container(
        padding: const EdgeInsets.all(16.0),
        width: 64,
        height: 64,
        child: SvgPicture.asset('assets/svg/dashboard.svg'),
      );
}
