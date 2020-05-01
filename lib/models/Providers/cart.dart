import 'package:flutter/foundation.dart';

class CartItem {
  final String prodId;
  final String title;
  final quantity;
  final double price;

  CartItem({this.prodId, this.title, this.quantity = 1, this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

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
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }
  double get totalPrice{
    var total = 0.0;
    _items.forEach((key,cartItem) => total += cartItem.quantity * cartItem.price);
    return total;
  }

  void removeItem(String prodId){
    _items.remove(prodId);
    notifyListeners();
  }
  void clearCart(){
    _items.clear();
    notifyListeners();
  }
}
