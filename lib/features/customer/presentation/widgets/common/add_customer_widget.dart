import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCustomerWidget extends StatelessWidget {
  const AddCustomerWidget(
      {Key? key, required this.onAddCustomer,
        required this.validateInput,
        required this.errorValidateMessage,
        required this.isCustomerLoading

      })
      : super(key: key);
  final Function(String name, String ID, String mobile_no, String email)
      onAddCustomer;
  final Function(String text, String type) validateInput;
  final errorValidateMessage  ;
  final isCustomerLoading ;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textNameEditingController =
        TextEditingController();
    final TextEditingController textEmailEditingController =
        TextEditingController();
    final TextEditingController textIDEditingController =
        TextEditingController();
    final TextEditingController textMobileNuEditingController =
        TextEditingController();


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            textAlign: TextAlign.right,
            controller: textIDEditingController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'رقم المعرف',
                labelStyle: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    color: const Color(0xff178F49),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            textAlign: TextAlign.right,
            controller: textNameEditingController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'اسم العميل',
                labelStyle: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    color: const Color(0xff178F49),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
          SizedBox(
            height: 5,
          ),
          Obx(() => TextField(
                textAlign: TextAlign.right,
                controller: textMobileNuEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '*رقم الجوال',
                  labelStyle: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      color: const Color(0xff178F49),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // textMobileNuEditingController.value.text!=null? errorText: 'ffff':
                  alignLabelWithHint: true,
                  errorStyle: errorValidateMessage.value.isEmpty
                      ? null
                      : GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  errorText: errorValidateMessage.value.isEmpty
                      ? null
                      : errorValidateMessage.value,
                ),
                onChanged: (value) {
                  //todo
                  errorValidateMessage.value = validateInput(value,
                      "أدخل رقم الجوال");
                },
              )),
          SizedBox(
            height: 5,
          ),
          TextField(
            textAlign: TextAlign.right,
            controller: textEmailEditingController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'الايميل',
                labelStyle: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    color: const Color(0xff178F49),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
          SizedBox(
            height: 8,
          ),
          Obx(() => Container(
              height: 50,
              color: Color(0xff178F49),
              width: double.infinity,
              child: isCustomerLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Obx(() => _buildElevatedButton(
                        onPressed: () =>
                            textMobileNuEditingController.value.text.isNotEmpty
                                ? onAddCustomer(
                                    textMobileNuEditingController.value.text,
                                    textNameEditingController.value.text,
                                    textIDEditingController.value.text,
                                    textEmailEditingController.value.text)
                                : errorValidateMessage.value = validateInput(
                                    textMobileNuEditingController.value.text,
                                "أدخل رقم الجوال"),

                      )))),
        ],
      ),
    );
  }

  ElevatedButton _buildElevatedButton({required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: errorValidateMessage.value.isEmpty
            ? const Color(0xff178f49)
            : const Color(0xff178f49),
        shadowColor: Colors.transparent,
      ),
      child: Text(
        "حفظ",
        style: GoogleFonts.cairo(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
