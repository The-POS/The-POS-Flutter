class Product {
  String sku;
  String name;
  int price;
  int taxRate;
  double taxedPrice;

  Product(
      {required this.sku,
      required this.name,
      required this.price,
      required this.taxRate,
      required this.taxedPrice});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      sku: json['sku'],
      name: json['name'],
      price: json['price'],
      taxRate: json['tax_rate'],
      taxedPrice: json['taxed_price']);
}
