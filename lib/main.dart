import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/cart.dart';
import 'package:shoplite1/models/Providers/product_provider.dart';
import 'package:shoplite1/screens/cart_screen.dart';
import 'package:shoplite1/screens/product_details_screen.dart';
import 'package:shoplite1/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider( //used to add multiple providers
      providers: [
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: ProductsScreen(),
        routes: {
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          CartScreen.routeName : (context) => CartScreen(),
        },
      ),
    );
  }
}
