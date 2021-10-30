import 'package:thepos/features/carts/data/models/cart.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/invoice/models/invoice.dart';
import 'package:thepos/features/invoice/models/invoice_item.dart';

final Product anyProduct =
    Product(name: 'test name', sku: 'test sku', price: 4);

const int anyQuantity = 2;

final Cart emptyCart = Cart(
  keyCart: '1',
  cartItems: <CartItem>[],
);

final Cart anyCart = Cart(
  keyCart: '1',
  cartItems: <CartItem>[CartItem(product: anyProduct, quantity: anyQuantity)],
);

final Invoice anyInvoice = Invoice(
  clientId: 0,
  items: <InvoiceItem>[InvoiceItem(product: anyProduct, quantity: anyQuantity)],
);

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
