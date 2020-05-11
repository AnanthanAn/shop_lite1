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
   final String _authToken ;
   final String _userId ;
   List<OrderItem> _items = [];

   Orders(this._authToken,this._userId,this._items);

  List<OrderItem> get items {
    return [..._items];
  }

  int get noOrders{
    return _items.length;
  }

  Future<void> fetchOrders() async {
    final url = 'https://shoplite-88df0.firebaseio.com/orders/$_userId.json?auth=$_authToken';
    List<OrderItem> _orderItems = [];
    var response = await http.get(url);
    var fetchedData = json.decode(response.body) as Map<String, dynamic>;
    print(fetchedData);
    fetchedData.forEach((orderId, order) {
      _orderItems.add(
        OrderItem(
            id: orderId,
            time: DateTime.parse(order['time']),
            total: order['total'],
            products: (order['products'] as List<dynamic>)
                .map((product) => CartItem(
                    prodId: product['id'],
                    title: product['title'],
                    price: product['price'],
                    quantity: product['quantity']))
                .toList()),
      );
    });
    _items = _orderItems.reversed.toList();
    print('order updated');
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> products, double total) async {
    final url = 'https://shoplite-88df0.firebaseio.com/orders/$_userId.json?auth=$_authToken';
    final timeStamp = DateTime.now();
    var response = await http.post(url,
        body: json.encode({
          'time': timeStamp.toIso8601String(),
          'total': total,
          'products': products
              .map((product) => {
                    'id': product.prodId,
                    'title': product.title,
                    'quantity': product.quantity,
                    'price': product.price
                  })
              .toList(),
        }));

    _items.insert(
        0,
        OrderItem(
            id: json.decode(
                response.body)['name'], //json.decode(response.body)['id'],
            products: products,
            total: total,
            time: timeStamp));
    notifyListeners();
  }
}
