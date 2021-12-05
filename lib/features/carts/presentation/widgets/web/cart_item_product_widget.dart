import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';
import 'package:thepos/features/carts/presentation/controllers/carts_controller.dart';
import 'package:thepos/features/carts/presentation/views/web/edit_cart.dart';

class CartItemProductWidget extends StatelessWidget {
  final CartItem item;
  final Function refresh;
  var cartsController = Get.find<CartsController>();

  CartItemProductWidget({Key? key, required this.item, required this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ListTile(
          onTap: () async {
            await showModalSideSheet(
                context: context,
                ignoreAppBar: false,
                barrierDismissible: true,
                withCloseControll: false,
                width: MediaQuery.of(context).size.width *
                    (GetPlatform.isMobile ? 0.80 : 0.25),
                body: SafeArea(
                  child: EditCartWidget(
                    item: item,
                  ),
                ));

            // if (GetPlatform.isMobile) {
            //   await Get.bottomSheet(
            //       EditCartWidget(
            //         item: item,
            //       ),
            //       isScrollControlled: true,
            //       backgroundColor: Colors.white);
            // } else {
            //   await Get.dialog(
            //     Material(
            //       child: EditCartWidget(
            //         item: item,
            //       ),
            //     ),
            //   );
            // }
            refresh();
          },
          leading: Text(
            "X ${item.quantity}",
            style: GoogleFonts.cairo(
              textStyle: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          trailing: RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: "${item.quantity * item.product.price}",
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: Color(0xff178F49),
                      fontSize: 27,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextSpan(
                text: "ريال",
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )),
          title: Text(
            "${item.product.name}",
            style: GoogleFonts.cairo(
              textStyle: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          )),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'حذف',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            cartsController.deleteItem(item);
            refresh();
          },
        ),
      ],
    );
  }
}
