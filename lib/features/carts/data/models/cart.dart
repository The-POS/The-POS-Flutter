import 'package:hive/hive.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';

part 'cart.g.dart';

@HiveType(typeId: 3)
class Cart {
  Cart({
     this.id,
    required this.keyCart,
    required this.cartItems,
  });
  @HiveField(0)
  String ?id;
  @HiveField(1)
  String keyCart;

  @HiveField(2)
  List<CartItem> cartItems;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json['id'],
        keyCart: json["keyCart"],
        cartItems: json["cartItems"] == null
            ? []
            : List<CartItem>.from(
                json["cartItems"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "keyCart": keyCart,
        "cartItems": cartItems == null
            ? []
            : List<dynamic>.from(cartItems.map((x) => x.toJson())),
      };
}
