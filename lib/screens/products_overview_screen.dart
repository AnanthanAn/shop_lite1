import 'package:flutter/material.dart';
import 'package:shoplite1/widgets/product_grid.dart';

enum PopupMenuOptions { Favourites, All }

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  var favOnly = false;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (PopupMenuOptions selectedOption) {
              setState(() {
                if (selectedOption == PopupMenuOptions.Favourites) {
                  favOnly = true;
                }
                if (selectedOption == PopupMenuOptions.All) {
                  favOnly = false;
                }
              });
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
      body: ProductGrid(favOnly: favOnly,),
    );
  }
}
