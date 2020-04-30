

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String desc;
  final String imageUrl;
  final double price;
  bool isFav;

  Product({
    @required this.id,
    @required this.title,
    @required this.desc,
    @required this.imageUrl,
    @required this.price,
    this.isFav = false,
});

  void toggleFavourite(){
    isFav = !isFav;
    notifyListeners();
  }
}