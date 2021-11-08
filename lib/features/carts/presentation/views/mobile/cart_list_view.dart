import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartListView extends StatelessWidget {
  const CartListView({Key? key, required this.selectedCartIndex})
      : super(key: key);

  final int selectedCartIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children:
            List<Widget>.generate(6, (int index) => _buildContainer(index)),
      ),
    );
  }

  Container _buildContainer(int index) {
    final bool selectedCart = selectedCartIndex == index;
    return Container(
      margin: const EdgeInsets.all(8),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: selectedCart ? Colors.orange : Colors.orange.withOpacity(0.4),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
