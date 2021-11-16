// ignore_for_file: always_specify_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/category.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/home/data/repositories/home_repository.dart';
import 'package:thepos/features/home/presentation/widgets/popup_choice_barcode.dart';

class HomeController extends GetxController {
  var listHomeProduct = <Product>[].obs;
  var newListHomeProduct = <Product>[].obs;
  var searching = false.obs;
  var barcoding = false.obs;

  RxBool loadingHome = false.obs;
  RxBool showHideCarts = false.obs;

  @override
  void onReady() {
    super.onReady();

    selectedCategory = listCategory.first;
    getProduct();
  }

  Category? selectedCategory;
  List<Category> listCategory = [
    Category(id: "1", name: "الطيور"),
    Category(id: "2", name: "القطط"),
    Category(id: "3", name: "الكلاب"),
  ]; //TODO get values from repository
  onSearch(String value) {
    newListHomeProduct.value = listHomeProduct.value
        .where(
            (string) => string.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  onBarcode(String value) {
    newListHomeProduct.value = listHomeProduct.value
        .where(
            (string) => string.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  Future getProduct() async {
    loadingHome.value = true;
    try {
      final homeRepo = getIt<HomeRepository>();
      listHomeProduct.value = await homeRepo.getProducts();
      newListHomeProduct = listHomeProduct.value.obs;
      print("Count PR  ${listHomeProduct.value.length}");
      update();
    } catch (e) {
      print("error getProduct $e");
    }
    loadingHome.value = false;
  }

  Future getProductsByGroupId() async {
    if (selectedCategory == null) {
      return;
    }
    try {
      listHomeProduct.value = await getIt<HomeRepository>()
          .getProductsByGroupId(int.parse(selectedCategory!.id));
      newListHomeProduct = listHomeProduct.value.obs;
      update();
    } catch (e) {
      print("error getProduct $e");
    }
    loadingHome.value = false;
  }

  Future changeCategory(Category cat) async {
    selectedCategory = cat;
    update();
    print("change");
    loadingHome.value = !loadingHome.value;
    getProductsByGroupId();
    refresh();
  }

  Future showHidCart() async {
    showHideCarts.value = !showHideCarts.value;
    update();
  }

  Future showSearch() async {
    searching.value = !searching.value;
    update();
  }

  Future showBarcode() async {
    barcoding.value = !barcoding.value;
    update();
  }

  String _scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    _scanBarcode = barcodeScanRes;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    _scanBarcode = barcodeScanRes;
  }

  void modalBottomSheetMenu4() {
    showModalBottomSheet(
        context: Get.context!,
        // use the shape border property to give it rounder corners
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (builder) {
          return const PopupChoiceBarcode();
        })
      .then((value) {
        if(value != null && value ==1){
          scanQR();
        }else if(value != null && value ==2){
          scanBarcodeNormal();
        }
      });
  }
}
