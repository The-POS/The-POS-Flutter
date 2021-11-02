

import 'package:thepos/features/products/product.dart';

abstract class ProductsLoader {
  Future<List<Product>> loadProducts();
}
