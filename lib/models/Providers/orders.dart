import 'package:flutter/foundation.dart';
import 'package:shoplite1/models/Providers/cart.dart';

class OrderItem {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime time;

  OrderItem({this.id, this.total, this.products, this.time});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  void addOrder(List<CartItem> products, double total) {
    _items.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            products: products,
            total: total,
            time: DateTime.now()));
    notifyListeners();
  }
}
