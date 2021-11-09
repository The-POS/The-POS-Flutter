import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditCartSegmentedControl extends StatefulWidget {
  const EditCartSegmentedControl({
    Key? key,
    required this.onSegmentSelected,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  final int quantity;
  final double price;
  final Function(int selectedSegmentIndex) onSegmentSelected;

  @override
  EditCartSegmentedControlState createState() =>
      EditCartSegmentedControlState();
}

class EditCartSegmentedControlState extends State<EditCartSegmentedControl> {
  int? groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: CupertinoSlidingSegmentedControl<int>(
        thumbColor: Theme.of(context).primaryColor,
        groupValue: groupValue,
        onValueChanged: (int? value) {
          setState(() {
            groupValue = value;
          });
          widget.onSegmentSelected(value ?? 0);
        },
        children: <int, Widget>{
          0: _buildSegment(
              index: 0, title: 'العدد', value: '${widget.quantity}'),
          1: _buildSegment(index: 1, title: 'السعر', value: '${widget.price}'),
        },
      ),
    );
  }

  Widget _buildSegment(
      {required int index, required String title, required String value}) {
    final Color textColor =
        index == groupValue ? CupertinoColors.white : CupertinoColors.black;
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.cairo(
              textStyle: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            value,
            style: GoogleFonts.cairo(
              textStyle: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
