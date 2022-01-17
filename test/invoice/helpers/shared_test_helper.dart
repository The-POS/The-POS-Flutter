import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/carts/data/models/cart.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice_item.dart';

final Product anyProduct =
    Product(name: 'test name', sku: 'test sku', price: 4);

const int anyQuantity = 2;

const double sellingPrice = 2.0;

final Cart emptyCart = Cart(
  keyCart: '1',
  cartItems: <CartItem>[],
);

final Cart anyCart = Cart(
  keyCart: '1',
  cartItems: <CartItem>[CartItem(product: anyProduct, quantity: anyQuantity,
      sellingPrice: sellingPrice)],
);

final InvoiceItem anyInvoiceItem =
    InvoiceItem(product: anyProduct, quantity: anyQuantity);

final Invoice anyInvoice = Invoice(
  clientId: 0,
  items: <InvoiceItem>[anyInvoiceItem],
);

Invoice createInvoice(int clientId, List<InvoiceItem> items) {
  return Invoice(
    clientId: clientId,
    items: items,
  );
}

final Map<String, dynamic> anyJsonInvoice = anyInvoice.toJson();

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

void expectInvoice(Invoice invoice, Invoice other) {
  expect(invoice.clientId, other.clientId);
  expect(invoice.items.length, other.items.length);
  for (int i = 0; i < invoice.items.length; i++) {
    expect(invoice.items[i].quantity, other.items[i].quantity);
    expectProduct(invoice.items[i].product, other.items[i].product);
  }
}

void expectProduct(Product product, Product other) {
  expect(product.sku, other.sku);
  expect(product.name, other.name);
  expect(product.price, other.price);
  expect(product.taxedPrice, other.taxedPrice);
  expect(product.taxRate, other.taxRate);
}
