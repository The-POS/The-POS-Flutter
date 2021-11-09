import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/mobile/editCart/edit_cart_product_item_widget.dart';
import '../../widgets/mobile/editCart/edit_cart_segmented_control.dart';

class EditCartItemView extends StatefulWidget {
  const EditCartItemView({
    Key? key,
    required this.quantity,
    required this.productImage,
    required this.productName,
    required this.productBarCode,
    required this.productPrice,
    required this.updatePrice,
    required this.updateQuantity,
  }) : super(key: key);

  final Function(double price) updatePrice;
  final Function(int quantity) updateQuantity;
  final int quantity;
  final String productImage;
  final String productName;
  final String productBarCode;
  final double productPrice;

  @override
  EditCartItemViewState createState() => EditCartItemViewState();
}

class EditCartItemViewState extends State<EditCartItemView> {
  int _selectedSegmentIndex = 0;
  String? _valueToUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 400,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          EditCartProductItemWidget(
            productImage: widget.productImage,
            productName: widget.productName,
            productBarCode: widget.productBarCode,
            productPrice: widget.productPrice,
          ),
          EditCartSegmentedControl(
            quantity: widget.quantity,
            price: widget.productPrice,
            onSegmentSelected: _onSegmentSelected,
          ),
          TextField(
            onChanged: (String value) {
              _valueToUpdate = value;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: _selectedSegmentIndex == 0 ? 'الكمية' : 'السعر',
            ),
          ),
          const SizedBox(height: 12),
          _buildActionButtonWidget(context),
        ],
      ),
    );
  }

  Widget _buildActionButtonWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildElevatedButton(
          title: 'تحديث',
          color: Theme.of(context).primaryColor,
          onPressed: _update,
        ),
        const SizedBox(
          width: 12,
        ),
        _buildElevatedButton(
          title: 'حذف',
          color: Colors.red,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildElevatedButton(
      {required String title,
      required Color color,
      required VoidCallback onPressed}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSegmentSelected(int selectedIndex) {
    setState(() {
      _selectedSegmentIndex = selectedIndex;
    });
  }

  void _update() {
    if (_valueToUpdate == null) {
      return;
    }
    if (_selectedSegmentIndex == 0) {
      final int newQuantity = int.parse(_valueToUpdate ?? '${widget.quantity}');
      widget.updateQuantity(newQuantity);
    } else {
      final double newPrice =
          double.parse(_valueToUpdate ?? '${widget.productPrice}');
      widget.updatePrice(newPrice);
    }
  }
}
