import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:thepos/features/customer/presentation/widgets/model/item_dropdown_list.dart';

part 'customer.g.dart';

@HiveType(typeId: 5)
class Customer extends Equatable implements DropListItem {

  Customer({
    this.name,
    required this.mobile_no,
    this.email,
    this.ID,
  });


  @HiveField(0)
  String? name;
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

  @override
  List<Object?> get props => [name, mobile_no, email, ID];


  @override
  bool isFooter() {
    return false;
  }

  @override
  bool isHeader() {
    return false ;
  }

  @override
 Customer? getCustomer() {
    return Customer(name :name ,mobile_no: mobile_no ,email: email,ID: ID);
  }


}
