import 'package:thepos/features%20/products_feature/product.dart';

abstract class ProductsLoader {
  Future<List<Product>> loadProducts();
}
