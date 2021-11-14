import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyPad extends StatelessWidget {
  const KeyPad(
      {Key? key,
      required this.onChange,
      required this.onSubmit,
      required this.textEditingController})
      : super(key: key);

  static const double buttonSize = 60.0;
  final TextEditingController textEditingController;
  final Function(String value) onChange;
  final Function(String value) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buttonWidget(context, '1'),
              buttonWidget(context, '2'),
              buttonWidget(context, '3'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buttonWidget(context, '4'),
              buttonWidget(context, '5'),
              buttonWidget(context, '6'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buttonWidget(context, '7'),
              buttonWidget(context, '8'),
              buttonWidget(context, '9'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              iconButtonWidget(context, Icons.backspace_outlined, () {
                if (textEditingController.text.isNotEmpty) {
                  textEditingController.text = textEditingController.text
                      .substring(0, textEditingController.text.length - 1);
                }
                if (textEditingController.text.length > 5) {
                  textEditingController.text =
                      textEditingController.text.substring(0, 3);
                }
                onChange(textEditingController.text);
              }),
              buttonWidget(context, '0'),
              buttonWidget(context, '.'),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Expanded buttonWidget(BuildContext context, String buttonText) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.green,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          side: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
        onPressed: () {
          if (textEditingController.text.length <= 10) {
            textEditingController.text =
                textEditingController.text + buttonText;
            onChange(textEditingController.text);
          }
        },
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }

  Expanded iconButtonWidget(
      BuildContext context, IconData icon, Function() function) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.green,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          side: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
        onPressed: function,
        icon: Center(
          child: Icon(
            icon,
            size: 30,
            color: Colors.black,
          ),
        ),
        label: const SizedBox(),
      ),
    );
  }
}
