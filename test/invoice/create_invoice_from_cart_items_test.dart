import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/carts/data/models/cart.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/invoice/models/invoice.dart';
import 'package:thepos/features/invoice/models/invoice_item.dart';

void main() {
  test('create invoice model return null on empty cart items', () {
    final Cart emptyCart = Cart(
      keyCart: '1',
      cartItems: <CartItem>[],
    );

    final Invoice? invoice =
        CartInvoiceMapper.createInvoiceFrom(cart: emptyCart);

    expect(invoice, null);
  });

  test('create invoice model success on non empty cart items', () {
    final Product testProduct =
        Product(name: 'test name', sku: 'test sku', price: 4);
    const int testQuantity = 2;

    final Cart cart = Cart(
      keyCart: '1',
      cartItems: <CartItem>[
        CartItem(product: testProduct, quantity: testQuantity)
      ],
    );

    final Invoice? invoice = CartInvoiceMapper.createInvoiceFrom(cart: cart);

    expect(invoice?.clientId, int.parse(cart.keyCart));
    expect(invoice?.items.length, 1);
    expect(invoice?.items.first.product.name, testProduct.name);
    expect(invoice?.items.first.product.sku, testProduct.sku);
    expect(invoice?.items.first.product.price, testProduct.price);
  });
}

mixin CartInvoiceMapper {
  static Invoice? createInvoiceFrom({required Cart cart}) {
    if (cart.cartItems.isNotEmpty) {
      final Invoice invoice = Invoice(
          clientId: int.parse(cart.keyCart),
          items: cart.cartItems
              .map<InvoiceItem>((CartItem cartItem) => InvoiceItem(
                    product: cartItem.product,
                    quantity: cartItem.quantity,
                  ))
              .toList());
      return invoice;
    } else {
      return null;
    }
  }
}
