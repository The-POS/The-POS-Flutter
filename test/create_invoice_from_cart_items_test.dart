import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';
import 'package:thepos/features/invoice/helper/cart_invoice_mapper.dart';

import 'invoice/helpers/shared_test_helper.dart';

void main() {
  test('create invoice model return null on empty cart items', () {
    final Invoice? invoice =
        CartInvoiceMapper.createInvoiceFrom(cart: emptyCart);

    expect(invoice, null);
  });

  test('create invoice model success on non empty cart items', () {
    final Invoice? invoice = CartInvoiceMapper.createInvoiceFrom(cart: anyCart);

    expect(invoice?.clientId, int.parse(anyCart.keyCart));
    expect(invoice?.items.length, 1);
    expect(invoice?.items.first.quantity, anyCart.cartItems.first.quantity);
    expect(invoice?.items.first.product.name,
        anyCart.cartItems.first.product.name);
    expect(
        invoice?.items.first.product.sku, anyCart.cartItems.first.product.sku);
    expect(invoice?.items.first.product.price,
        anyCart.cartItems.first.product.price);
  });
}
