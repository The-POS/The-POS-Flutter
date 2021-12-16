import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/carts/data/models/customer.dart';

final Customer anyCustomer = Customer(mobile_no: '4444466444',name: "duaa",email: "duaa@gmail.com",
ID:"c12334");


Customer createCustomer(Customer item) {
  return Customer(mobile_no: item.mobile_no,name: item.name,ID: item.ID,email: item.email);
}

final Map<String, dynamic> anyJsonCustomer= anyCustomer.toJson();

final Exception anyException = Exception();

typedef TryFunction = Future<dynamic> Function();

dynamic tryFunction(TryFunction function) async {
  dynamic expectedError;
  try {
    await function();
  } catch (error) {
    expectedError = error;
  }
  return expectedError;
}

void expectCustomer(Customer customer, Customer other) {
  expect(customer.mobile_no, other.mobile_no);

}

