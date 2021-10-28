import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/product.dart';

class HomeLocalDataSource {
  static const String cacheTimeKey = 'cachedProductTime';

  Future<List<Product>> getProducts() async {
    return productsBox.values.toList();
  }

  Future<Iterable<int>> insertProducts(List<Product> products) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt(
        cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
    return productsBox.addAll(products);
  }

  Future<List<Product>> getProductsByGroupId(int groupId) async {
    return productsBox.values.where((pr) => pr.groupId == groupId).toList();
  }
}
