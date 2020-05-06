import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shoplite1/models/Providers/cart.dart';
import 'package:http/http.dart' as http;

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

  void addOrder(List<CartItem> products, double total) async{
    final url = 'https://shoplite-88df0.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    var response = await http.post(url,body: json.encode({
      'time' : timeStamp.toIso8601String(),
      'total' : total,
      'products' : products.map((product) =>{
        'id' : product.prodId,
        'title' : product.title,
        'quantity' : product.quantity,
        'price' : product.price
      }).toList(),
    }));

    _items.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['id'],//json.decode(response.body)['id'],
            products: products,
            total: total,
            time: timeStamp));
    notifyListeners();
  }
}
