
import 'package:thepos/features/customer/data/models/customer.dart';
import 'package:thepos/features/customer/presentation/widgets/model/item_dropdown_list.dart';


class footer extends DropListItem{
  footer({required this.checkIsFooter});
  final bool checkIsFooter ;

  @override
  bool isFooter() {
    return checkIsFooter ;
  }

  @override
  Customer? getCustomer() {
    return null;
  }
@override
  String toString() {

  return "إضافة جديد" ;
  }
}