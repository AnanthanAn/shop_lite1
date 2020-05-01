import 'package:flutter/foundation.dart';

class CartItem {
  final String prodId;
  final String title;
  int quantity = 1;
  final double price;

  CartItem({this.prodId, this.title, this.quantity, this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem({prodId, title, price}) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (cartitem) => CartItem(
              prodId: cartitem.prodId,
              title: cartitem.title,
              price: cartitem.price,
              quantity: cartitem.quantity + 1));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
              prodId: DateTime.now().toString(), title: title, price: price));
    }
  }
}
