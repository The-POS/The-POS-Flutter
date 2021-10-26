import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/product.dart';

class HomeLocalDataSource {
  Future<List<Product>> getProducts() async {
    return productsBox.values.toList();
  }

  Future<Iterable<int>> insertProducts(List<Product> products) async {
    return productsBox.addAll(products);
  }

  Future<List<Product>> getProductsByGroupId(int groupId) async {
    return productsBox.values.where((pr) => pr.groupId == groupId).toList();
  }
}
