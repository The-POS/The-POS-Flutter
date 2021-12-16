import 'package:hive/hive.dart';
part 'customer.g.dart';

@HiveType(typeId: 5)
class Customer {
  Customer({
    this.name,
    required this.mobile_no,
    this.email,
    this.ID,
  });

  @HiveField(0)
  String ?name;
  @HiveField(1)
  String mobile_no;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? ID;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    name: json['name'],
    mobile_no: json["mobile_no"],
    email: json["email"],
    ID: json["ID"],

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile_no": mobile_no,
    "email": email,
    "ID": ID,
  };
}
