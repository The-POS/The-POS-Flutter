import '../product.dart';

class Products {
  List<Product> data;

  Products({required this.data});

  factory Products.fromJson(Map<String, dynamic> json) {
    List<Product> products = [];
    final data = json['data'];
    data.forEach((value) {
      products.add(Product.fromJson(value));
    });
    return Products(data: products);
  }
}
