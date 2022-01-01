import 'package:thepos/features/customer/data/models/customer.dart';

class Customers {
  List<Customer> data;

  Customers({required this.data});

  factory Customers.fromJson(Map<String, dynamic> json) {
    List<Customer> products = [];
    final data = json['data'];
    data.forEach((value) {
      products.add(Customer.fromJson(value));
    });
    return Customers(data: products);
  }
}