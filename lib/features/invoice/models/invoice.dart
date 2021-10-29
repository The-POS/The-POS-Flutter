import 'invoice_item.dart';

class Invoice {
  Invoice({required this.clientId, required this.items});

  factory Invoice.fromJson(Map<String, dynamic> json) {
    final int clientId = json['client_id'];
    final List<InvoiceItem> invoiceItems = <InvoiceItem>[];
    final List<Map<String, dynamic>> items = json['items'];
    for (final Map<String, dynamic> value in items) {
      invoiceItems.add(InvoiceItem.fromJson(value));
    }
    return Invoice(clientId: clientId, items: invoiceItems);
  }

  int clientId;
  List<InvoiceItem> items;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_id'] = clientId;
    data['items'] = items.map((InvoiceItem value) => value.toJson()).toList();
    return data;
  }
}
