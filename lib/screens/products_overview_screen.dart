import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/product_provider.dart';
import 'package:shoplite1/screens/product_details_screen.dart';
import 'package:shoplite1/widgets/product_item.dart';

enum PopupMenuOptions { Favourites, All }

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favOnly = false;
    final prodProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Shop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (PopupMenuOptions selectedOption) {

              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Favourites'),
                  value: PopupMenuOptions.Favourites,
                ),
                PopupMenuItem(
                  child: Text('All'),
                  value: PopupMenuOptions.All,
                )
              ],
            )
          ],
        ),
        body: ProductItem());
  }
}
