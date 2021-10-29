import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepos/core/config.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/products_feature/product_cache_policy.dart';

class HomeLocalDataSource {
  static const String cacheTimeKey = 'cachedProductTime';

  Future<List<Product>> getProducts() async {
    final bool isCacheExpired = await _isCacheExpired();
    if (isCacheExpired) {
      await productsBox.deleteFromDisk();
      return <Product>[];
    } else {
      return productsBox.values.toList();
    }
  }

  Future<Iterable<int>> insertProducts(List<Product> products) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt(
        cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
    return productsBox.addAll(products);
  }

  Future<List<Product>> getProductsByGroupId(int groupId) async {
    final bool isCacheExpired = await _isCacheExpired();
    if (isCacheExpired) {
      await productsBox.deleteFromDisk();
      return <Product>[];
    } else {
      return productsBox.values
          .where((Product product) => product.groupId == groupId)
          .toList();
    }
  }

  Future<bool> _isCacheExpired() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final int? cachedProductTime = sharedPreferences.getInt(cacheTimeKey);
    if (cachedProductTime == null) {
      return false;
    }
    final DateTime cachedDateTime =
        DateTime.fromMillisecondsSinceEpoch(cachedProductTime);
    final ProductCachePolicy cachePolicy = ProductCachePolicy(
      productsCacheTimeIntervalInHours,
      cachedDateTime,
    );
    return cachePolicy.isExpired(currentDateTime: DateTime.now());
  }
}
