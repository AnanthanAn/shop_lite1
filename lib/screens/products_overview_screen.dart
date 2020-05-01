import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/cart.dart';
import 'package:shoplite1/screens/cart_screen.dart';
import 'package:shoplite1/widgets/app_drawer.dart';
import 'package:shoplite1/widgets/badge.dart';
import 'package:shoplite1/widgets/product_grid.dart';

enum PopupMenuOptions { Favourites, All }

class ProductsScreen extends StatefulWidget {
  static const routeName = '/home-screen';

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
          Consumer<Cart>(
            builder: (_, cart, _2) => Badge(
                child: IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },),
                value: cart.itemsCount.toString(),color: Colors.lightGreen,),
          ),
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
      body: ProductGrid(
        favOnly: favOnly,
      ),
      drawer: AppDrawer(),
    );
  }
}
