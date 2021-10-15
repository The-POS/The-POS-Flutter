import 'package:thepos/products_feature/product.dart';

abstract class ProductsLoader {
  Future<List<Product>> loadProducts();
}
