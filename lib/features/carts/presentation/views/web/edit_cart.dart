import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';
import 'package:thepos/features/carts/presentation/controllers/carts_controller.dart';
import 'package:thepos/features/carts/presentation/widgets/common/key_pad.dart';

class EditCartWidget extends StatefulWidget {
  const EditCartWidget({Key? key, required this.item}) : super(key: key);
  final CartItem item;

  @override
  _EditCartWidgetState createState() => _EditCartWidgetState();
}

class _EditCartWidgetState extends State<EditCartWidget> {
  TextEditingController pinController = TextEditingController();
// final cartsController = Get.put(CartsController());
  var cartsController = Get.find<CartsController>();

  @override
  void initState() {
    // _controller.defaultHintText = "111";
    // _controller.rawNumber = "111";
    // _controller.inputValid = true;
    super.initState();
    refreshView();
  }

  bool isPriceSelected = false;
  refreshView() {
    if (isPriceSelected == true) {
      pinController.text = widget.item.getPrice.toString();
    } else {
      pinController.text = widget.item.quantity.toString();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${widget.item.product.name}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                            color: Color(0xff000000),
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: "الباركود : ",
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextSpan(
                          text:
                              "${faker.datatype.number(min: 10000000, max: 932838389)}",
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )),
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: "السعر : ",
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextSpan(
                          text: "${widget.item.getPrice} ريال",
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ))
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 100,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xffffffff),
                    border:
                        Border.all(width: 1.0, color: const Color(0xffdadada)),
                  ),
                  child: Image.network(
                    faker.image.loremPicsum.image(),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),

          Container(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      print("222");

                      setState(() {
                        isPriceSelected = true;
                      });
                      refreshView();
                    },
                    child: Container(
                      color: isPriceSelected ? Colors.white : Color(0xffF4F5FA),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Color(
                                  isPriceSelected ? 0xff178f49 : 0xffE6E6E6),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${widget.item.getPrice}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "السعر",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      print("11111");
                      setState(() {
                        isPriceSelected = false;
                      });
                      refreshView();
                    },
                    child: Container(
                      color:
                          !isPriceSelected ? Colors.white : Color(0xffF4F5FA),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Color(
                                  !isPriceSelected ? 0xff178f49 : 0xffE6E6E6),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${widget.item.quantity}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "العدد",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xfff4f5fa),
              border: Border.all(width: 1.0, color: const Color(0xffdadada)),
            ),
            child: Text(
              "${pinController.text}",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                    color: Color(0xff000000),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // Padding(
          //     padding: EdgeInsets.all(16),
          //     child: Text(pinController.text, style: TextStyle(fontSize: 40))),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: KeyPad(
              onChange: (t) {
                setState(() {});
              },
              onSubmit: (t) {
                setState(() {});
              },
              textEditingController: pinController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        if (isPriceSelected == true) {
                          widget.item.sellingPrice =
                              double.parse(pinController.text);
                        } else {
                          widget.item.quantity = int.parse(pinController.text);
                        }
                        cartsController.deleteItem(widget.item);
                        Get.back();
                      },
                      child: Container(
                        // width: 60,
                        // height: 60,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xffE14646),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Text(
                          "حذف",
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (isPriceSelected == true) {
                        // todo price
                        widget.item.product.price =
                            double.parse(pinController.text);
                      } else {
                        widget.item.quantity = int.parse(pinController.text);
                      }
                      cartsController.updateItem(widget.item);
                      Get.back();
                    },
                    child: Container(
                      // width: 60,
                      // height: 60,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xff178F49),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "تحديث",
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
