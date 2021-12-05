// ignore_for_file: always_specify_types

import 'package:get/get.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/category.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/home/data/repositories/home_repository.dart';

class HomeController extends GetxController {
  var listHomeProduct = <Product>[].obs;
  var newListHomeProduct = <Product>[].obs;
  var loadingHome = false.obs;
  var showHideCarts = false.obs;
  var searching = false.obs;
  Category? selectedCategory;
  List<Category> listCategory = []; //TODO get values from repository
  @override
  void onReady() {
    super.onReady();
    getProductsCategories();
    //getProduct();
  }

  onSearch(String value) {
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
    try {
      await getIt<HomeRepository>()
          .getProductsByGroupId(int.parse(selectedCategory!.id.toString()))
          .then((value) {
        newListHomeProduct.value.clear();
        newListHomeProduct.value.addAll(value);
        update();
      });

      update();
    } catch (e) {
      print("error getProduct $e");
    }
    loadingHome.value = false;
  }

  Future getProductsCategories() async {
    try {
      listCategory = await getIt<HomeRepository>().getProductsCategories();

      update();
    } catch (e) {
      print("error getProductsCategories $e");
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
}
