import 'package:flutter/material.dart';

class KeyPad extends StatelessWidget {
  double buttonSize = 60.0;
  final TextEditingController pinController;
  final Function onChange;
  final Function onSubmit;
  final bool isPinLogin;

  KeyPad(
      {required this.onChange,
      required this.onSubmit,
      required this.pinController,
      required this.isPinLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('1'),
              buttonWidget('2'),
              buttonWidget('3'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('4'),
              buttonWidget('5'),
              buttonWidget('6'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('7'),
              buttonWidget('8'),
              buttonWidget('9'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              iconButtonWidget(Icons.backspace_outlined, () {
                if (pinController.text.length > 0) {
                  pinController.text = pinController.text
                      .substring(0, pinController.text.length - 1);
                }
                if (pinController.text.length > 5) {
                  pinController.text = pinController.text.substring(0, 3);
                }
                onChange(pinController.text);
              }),
              buttonWidget('0'),
              SizedBox(
                width: buttonSize,
                height: buttonSize,
              )
              // !isPinLogin
              //     ? iconButtonWidget(Icons.check_circle, () {
              //         if (pinController.text.length > 5) {
              //           pinController.text = pinController.text.substring(0, 3);
              //         }
              //         onSubmit(pinController.text);
              //       })
              //     : Container(
              //         width: buttonSize,
              //       ),
            ],
          ),
        ],
      ),
    );
  }

  buttonWidget(String buttonText) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: buttonSize,
      width: buttonSize * 1.6,
      child: RaisedButton(
        // color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusColor: Colors.green,
        hoverColor: Colors.green,
        highlightColor: Colors.green,
        onPressed: () {
          if (pinController.text.length <= 10) {
            pinController.text = pinController.text + buttonText;
            onChange(pinController.text);
          }
        },
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }

  iconButtonWidget(IconData icon, Function() function) {
    return InkWell(
      onTap: function,
      child: Container(
        height: buttonSize,
        width: buttonSize * 1.6,
        decoration:
            BoxDecoration(color: Colors.orangeAccent, shape: BoxShape.circle),
        child: Center(
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
