import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/carts/data/models/cart.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';
import 'package:thepos/features/invoice/models/invoice.dart';

void main() {
  test('create invoice return null on empty cart items', () {
    final Cart emptyCart = Cart(
      keyCart: '1',
      cartItems: <CartItem>[],
    );

    final Invoice? invoice =
        CartInvoiceMapper.createInvoiceFrom(cart: emptyCart);

    expect(invoice, null);
  });
}

mixin CartInvoiceMapper {
  static Invoice? createInvoiceFrom({required Cart cart}) {
    if (cart.cartItems.isEmpty) {
      return null;
    }
  }
}
