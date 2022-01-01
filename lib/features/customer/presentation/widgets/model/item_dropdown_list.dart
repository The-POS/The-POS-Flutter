import 'package:thepos/features/customer/data/models/customer.dart';

abstract class DropListItem {

  bool isFooter();
  Customer? getCustomer();
}