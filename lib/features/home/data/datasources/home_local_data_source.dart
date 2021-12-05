import 'package:thepos/core/config.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/category.dart';
import 'package:thepos/core/preferences_utils.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/products/product_cache_policy.dart';

class HomeLocalDataSource {
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
    PreferenceUtils.setCacheTime(DateTime.now().millisecondsSinceEpoch);
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

  Future<List<Category>> getProductsCategories() async {
    return categoriesBox.values.toList();
  }

  Future<bool> _isCacheExpired() async {
    final int cachedProductTime = await PreferenceUtils.getCacheTime();
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
