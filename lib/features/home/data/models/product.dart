import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product {
  Product({
    required this.sku,
    required this.name,
    required this.price,
    this.groupId,
    this.taxRate,
    this.taxedPrice,
  });
  @HiveField(0)
  String sku;
  @HiveField(1)
  String name;
  @HiveField(2)
  double price;
  @HiveField(3)
  double? taxRate;
  @HiveField(4)
  double? taxedPrice;
  int? groupId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        sku: json['sku'],
        name: json["name"],
        groupId: json["groupId"] == null ? 0 : json["groupId"],
        price: json["price"] == null ? 0 : json["price"].toDouble(),
        taxRate: json["tax_rate"]?.toDouble(),
        taxedPrice: json["taxed_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "sku": sku,
        "name": name,
        "price": price,
        "tax_rate": taxRate,
        "taxed_price": taxedPrice,
      };
}
