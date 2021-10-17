import 'package:get/get.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/home/data/repositories/home_repository.dart';

class HomeController extends GetxController {
  List<Product> listHomeProduct = [];
  var loadingHome = false.obs;

  final listCat = [
    "الكل",
    "الكلاب",
    "القطط",
    "الطيور"
  ]; //TODO get value from controller

  Future getProduct() async {
    loadingHome.value = true;
    try {
      listHomeProduct = await getIt<HomeRepository>().getProducts();
      update();
    } catch (e) {
      print("error getProduct $e");
    }
    loadingHome.value = false;
  }
}
