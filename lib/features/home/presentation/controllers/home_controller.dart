// ignore_for_file: always_specify_types

import 'package:get/get.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/category.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/home/data/repositories/home_repository.dart';

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

    getProduct();
  }

  Category? selectedCategory;
  List<Category> listCategory = [
    Category(id: "1", name: "الطيور"),
    Category(id: "2", name: "القطط"),
    Category(id: "3", name: "الكلاب"),
    Category(id: "4", name: "الكل")
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
      listHomeProduct.value = await getIt<HomeRepository>().getProducts();
      newListHomeProduct = listHomeProduct.value.obs;
      print("Count PR  ${listHomeProduct.value.length}");
      update();
    } catch (e) {
      print("error getProduct $e");
    }
    loadingHome.value = false;
  }

  Future getProductsByGroupId() async {
    if (selectedCategory != null) {
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
}

