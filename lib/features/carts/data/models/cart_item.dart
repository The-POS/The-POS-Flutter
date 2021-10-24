import 'package:hive/hive.dart';
import 'package:thepos/features/home/data/models/product.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 4)
class CartItem {
  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });
  @HiveField(0)
  String id;
  @HiveField(1)
  Product product;
  @HiveField(2)
  int quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json['id'],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product.toJson(),
      };
}
