import 'package:thepos/features/customer/data/models/customer.dart';

import 'invoice_item.dart';

class Invoice {
  Invoice({required this.clientId, required this.items,this.customer});

  factory Invoice.fromJson(Map<String, dynamic> json) {
    final int clientId = json['client_id'];
    final List<InvoiceItem> invoiceItems = <InvoiceItem>[];
    final List<dynamic> items = json['items'];
    for (final Map<String, dynamic> value in items) {
      invoiceItems.add(InvoiceItem.fromJson(value));
    }
    final Customer customer = Customer.fromJson(json['customer']);
    return Invoice(clientId: clientId, items: invoiceItems,customer: customer);
  }

  int clientId;
  List<InvoiceItem> items;
  Customer? customer ;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_id'] = clientId;
    if (customer!=null)
      data['customer']=customer!.toJson();
    data['items'] = items.map((InvoiceItem value) => value.toJson()).toList();
    return data;
  }
}
