import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/customer/data/models/customer.dart';

final Customer anyCustomer = Customer(mobile_no: '44444644336644',name: "duaa",email: "duaa@gmail.com",
ID:"c12334");


Customer createCustomer(Customer item) {
  return Customer(mobile_no: item.mobile_no,name: item.name,ID: item.ID,email: item.email);
}

final Map<String, dynamic> anyJsonCustomer= anyCustomer.toJson();


void expectCustomer(Customer customer, Customer other) {
  expect(customer.mobile_no, other.mobile_no);

}

