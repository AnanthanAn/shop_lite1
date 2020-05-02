import 'package:flutter/material.dart';
import 'package:shoplite1/screens/orders_screen.dart';
import 'package:shoplite1/screens/products_overview_screen.dart';
import 'package:shoplite1/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello There'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Shop Menu'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ProductsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('My orders'),
            onTap: () {
              Navigator.pushNamed(context, OrderScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('My Products'),
            onTap: () {
              Navigator.pushNamed(context, UserProductsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
