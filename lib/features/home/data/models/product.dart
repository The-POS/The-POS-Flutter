import 'package:hive/hive.dart';
import 'package:thepos/features/home/data/models/category.dart';

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
    this.category,
    this.salePrice,
    this.taxedSalePrice,
    this.available,
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
  Category? category;

  @HiveField(5)
  double? salePrice;
  @HiveField(6)
  double? taxedSalePrice;

  @HiveField(7)
  bool? available;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        sku: json['sku'],
        name: json["name"],
        groupId: json["groupId"] == null ? 0 : json["groupId"],
        category: json["product_category"] == null
            ? null
            : Category.fromJson(json["product_category"]),
        price: json["price"] == null ? 0 : json["price"].toDouble(),
        salePrice:
            json["sale_price"] == null ? 0 : json["sale_price"].toDouble(),
        available: json["available"] == null ? true : json["available"],
        taxRate: json["tax_rate"]?.toDouble(),
        taxedPrice: json["taxed_price"]?.toDouble(),
        taxedSalePrice: json["taxed_sale_price"] == null
            ? 0
            : json["taxed_sale_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "sku": sku,
        "name": name,
        "price": price,
        "tax_rate": taxRate,
        "taxed_price": taxedPrice,
        "product_category": category,
        "sale_price": salePrice,
        "available": available,
        "taxed_sale_price": taxedSalePrice,
      };
}
