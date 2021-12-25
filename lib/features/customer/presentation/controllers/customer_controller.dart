import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/customer/data/models/customer.dart';
import 'package:thepos/features/customer/data/serives/data_sources/remote_customer.dart';
import 'package:thepos/features/customer/presentation/widgets/model/footer.dart';
import 'package:thepos/features/customer/presentation/widgets/model/item_dropdown_list.dart';
import 'package:thepos/features/customer/presentation/widgets/common/add_customer_widget.dart';

class CustomerController extends GetxController {
  RxList<Customer> listCustomer = <Customer>[].obs;
  Rx<DropListItem?> selectedCustomer = null.obs;
  var isCustomerLoading = false.obs;
  var errorValidateMessage = "".obs;
  var searching = false.obs;

  Customer customer = Customer(mobile_no: "choose customer");

  @override
  void onReady() {
    super.onReady();
    getCustomers();
  }

  void showDialogAddCustomer() {
    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 110, vertical: 10),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      title: 'اضافة عميل جديد',
      titleStyle: GoogleFonts.cairo(
        textStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      barrierDismissible: true,
      radius: 5,
      content: AddCustomerWidget(
        onAddCustomer: addCustomer,
        validateInput: validateInput,
        errorValidateMessage: errorValidateMessage,
        isCustomerLoading: isCustomerLoading,
      ),
    );
  }

  String? validateInput(String? value, String error) {
    if (value == null || value.isEmpty) {
      return error;
    }
    return "";
  }

  Future<void> addCustomer(
      String mobile, String name, String ID, String email) async {
    isCustomerLoading.value = true;
    var customer =
        Customer(mobile_no: mobile, name: name, ID: ID, email: email);

    if (customer != null) {
      final RemoteCustomer storeCustomer = getIt<RemoteCustomer>();
      try {
        await storeCustomer.store(customer);
        isCustomerLoading.value = false;
        Get.back();
        Get.snackbar("تم", "تم حفظ العميل الجديد",
            backgroundColor: const Color(0xff178F49).withOpacity(0.5),
            snackPosition: SnackPosition.BOTTOM);
      } catch (error) {
        isCustomerLoading.value = false;
        Get.snackbar("خطأ", "$error",
            backgroundColor: const Color(0xffec383d).withOpacity(0.5),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<void> getCustomers() async {
    try {
      final RemoteCustomer customerStore = getIt<RemoteCustomer>();
      listCustomer.value = await customerStore.load();
      update();
    } catch (e) {
      print("error getCustomers $e");
    }
  }

  Future<List<DropListItem>> onSearch(String value) async {
    List<DropListItem> listCustomerSearch = [];
    listCustomerSearch.addAll(listCustomer.value
        .where((customer) =>
        customer.toString().toLowerCase().contains(value.toLowerCase()))
        .toList());

    listCustomerSearch.add(footer(checkIsFooter: true));
    return listCustomerSearch;
  }
}
