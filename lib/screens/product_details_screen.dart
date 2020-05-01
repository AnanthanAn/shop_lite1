import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoplite1/models/Providers/product_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final selectedId = ModalRoute.of(context).settings.arguments as String;

    final prodProvider = Provider.of<ProductProvider>(context);
    final prodItem = prodProvider.findById(selectedId);

    //final Product appTitle =
    //prodItems.where((item) => item.id == selectedId);

    return Scaffold(
      appBar: AppBar(
        title: Text(prodItem.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              prodItem.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            prodItem.title,
            softWrap: true,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '₹${prodItem.price}',
            softWrap: true,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            prodItem.desc,
            softWrap: true,
            style: TextStyle(fontSize: 18,),
          ),
        ],
      ),
    );
  }
}
