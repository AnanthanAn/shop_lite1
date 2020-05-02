import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/product_provider.dart';
import 'package:shoplite1/screens/add_item_screen.dart';
import 'package:shoplite1/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddItemScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.items.length,
        itemBuilder: (_, idx) => UserProductItem(
            id: products.items[idx].id,
            title: products.items[idx].title,
            imageUrl: products.items[idx].imageUrl),
      ),
    );
  }
}
