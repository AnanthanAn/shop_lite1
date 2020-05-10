import 'package:flutter/material.dart';
import 'package:shoplite1/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  final String _authToken;

  ProductProvider(this._authToken,this._items);

  List<Product> _items = [
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((item) => item.isFav == true).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> fetchProducts() async {
    var url = 'https://shoplite-88df0.firebaseio.com/products.json?auth=$_authToken';
    try {
      final response = await http.get(url);
      final prodData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> newList = [];
      prodData.forEach((prodId, prodData) {
        var newProduct = Product(
            id: prodId,
            title: prodData['title'],
            desc: prodData['desc'],
            imageUrl: prodData['imageUrl'],
            price: double.parse(prodData['price'].toString()));
        newList.add(newProduct);
      });

      print(_items.length);
      _items = newList;
      print(_items.length);
    } catch (error) {
      print('Error in fetchProducts method - ${error.toString()}');
      throw error;
    }

    notifyListeners();
  }

  void addProduct(Product product) async {
    var url = 'https://shoplite-88df0.firebaseio.com/products.json';
    final response = await http.post(url,
        body: json.encode({
          'title': product.title,
          'desc': product.desc,
          'price': product.price,
          'imageUrl': product.imageUrl
        }));
    final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        desc: product.desc,
        imageUrl: product.imageUrl,
        price: product.price);
    _items.add(newProduct);
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
