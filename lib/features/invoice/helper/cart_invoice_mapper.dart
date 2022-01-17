import 'package:thepos/features/carts/data/models/cart.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';

import '../data/models/invoice.dart';
import '../data/models/invoice_item.dart';

mixin CartInvoiceMapper {
  static Invoice? createInvoiceFrom({required Cart cart}) {
    if (cart.cartItems.isNotEmpty) {
      final Invoice invoice = Invoice(
          clientId: int.parse(cart.keyCart),
          customer: cart.customer,
          items: cart.cartItems
              .map<InvoiceItem>((CartItem cartItem) => InvoiceItem(
                    product: cartItem.product,
                    quantity: cartItem.quantity,
                    sellingPrice: cartItem.sellingPrice,
                    taxedSellingPrice: cartItem.taxedSellingPrice
                  ))
              .toList());
      return invoice;
    } else {
      return null;
    }
  }
}
