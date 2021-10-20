
import 'package:thepos/features/products_feature/product.dart';

abstract class ProductsLoader {
  Future<List<Product>> loadProducts();
}
