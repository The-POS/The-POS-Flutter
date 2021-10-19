// ignore_for_file: always_specify_types

import 'package:get/get.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/category.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/home/data/repositories/home_repository.dart';

class HomeController extends GetxController {
  var listHomeProduct = <Product>[].obs;
  var listCarts =
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].obs; //TODO Create Model Cart
  var loadingHome = false.obs;
  var showHideCarts = false.obs;

  @override
  void onReady() {
    super.onReady();

    getProduct();
  }

  Category? selectedCat;
  List<Category> listCategory = [
    Category(id: "1", name: "الطيور"),
    Category(id: "2", name: "القطط"),
    Category(id: "3", name: "الكلاب"),
    Category(id: "4", name: "الكل")
  ]; //TODO get values from repository

  Future getProduct() async {
    loadingHome.value = true;
    try {
      listHomeProduct.value = await getIt<HomeRepository>().getProducts();

      print("Count PR  ${listHomeProduct.value.length}");
      update();
    } catch (e) {
      print("error getProduct $e");
    }
    loadingHome.value = false;
  }

  Future getProductsByGroupId() async {
    if (selectedCat != null) {
      return;
    }
    try {
      listHomeProduct.value = await getIt<HomeRepository>()
          .getProductsByGroupId(int.parse(selectedCat!.id));
      update();
    } catch (e) {
      print("error getProduct $e");
    }
    loadingHome.value = false;
  }

  Future changeCategory(Category cat) async {
    selectedCat = cat;
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
}
