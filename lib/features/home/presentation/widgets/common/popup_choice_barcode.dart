import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupChoiceBarcode extends StatelessWidget {
  const PopupChoiceBarcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Container(
          color: Colors.grey[350],
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3.0),
                    topRight: Radius.circular(3.0))),
            //content starts
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: Get.width,
                      child: CupertinoButton(
                        //special button for ios on click fadecolor
                        onPressed: () async {
                          Get.back(result: 1);
                        },
                        color: CupertinoColors.activeBlue,
                        pressedOpacity: 0.4,
                        child: const Text(" Scan QR "), //its has min length
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: Get.width,
                      child: CupertinoButton(
                        //special button for ios on click fadecolor
                        onPressed: () async {
                          Get.back(result: 2);
                        },
                        color: CupertinoColors.activeBlue,
                        pressedOpacity: 0.4,
                        child:
                            const Text(" Scan Barcode "), //its has min length
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
