import 'package:flutter/material.dart';
import 'package:shoplite1/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'OnePlus 8',
      desc: 'Never Settle',
      imageUrl:
          'https://static.hub.91mobiles.com/wp-content/uploads/2019/10/oneplus-8-pro-5K-render-2.jpg',
      price: 41000,
    ),
    Product(
      id: 'p2',
      title: 'T-Shirt',
      desc: 'Cool mallu T-Shirt for men',
      imageUrl:
          'https://www.mydesignation.com/wp-content/uploads/2019/02/but-why-tshirt-final-demo-1.jpg',
      price: 350.99,
    ),
    Product(
      id: 'p3',
      title: 'Shoes',
      desc: 'Cool Addidas Shoes, Not Adibas',
      imageUrl:
          'https://assets.adidas.com/images/w_600,f_auto,q_auto/56dc11ee795042b8b201a9f401213cf5_9366/Lite_Racer_Adapt_Shoes_Black_F36661_01_standard.jpg',
      price: 4000,
    ),
    Product(
      id: 'p4',
      title: 'Headset',
      desc: 'Listen to music now',
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0188/6001/5680/products/hf002-black-china-dacom-hf002-bluetooth-5-0-headphone-with-built-in-mic-cueboss-com-13549387481152_600x.jpg?v=1586531860',
      price: 2500,
    )
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

  void addProduct(Product product) {
    var newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        desc: product.desc,
        imageUrl: product.imageUrl,
        price: product.price);
    _items.add(newProduct);

    notifyListeners();
  }
}
