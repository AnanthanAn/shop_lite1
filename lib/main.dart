import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/auth.dart';
import 'package:shoplite1/models/Providers/cart.dart';
import 'package:shoplite1/models/Providers/orders.dart';
import 'package:shoplite1/models/Providers/product_provider.dart';
import 'package:shoplite1/screens/add_item_screen.dart';
import 'package:shoplite1/screens/auth_screen.dart';
import 'package:shoplite1/screens/cart_screen.dart';
import 'package:shoplite1/screens/orders_screen.dart';
import 'package:shoplite1/screens/product_details_screen.dart';
import 'package:shoplite1/screens/products_overview_screen.dart';
import 'package:shoplite1/screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        //used to add multiple providers
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, ProductProvider>(
            update: (context, auth, previous) => ProductProvider(
                auth.token, previous.items == null ? [] : previous.items),
            create: (_) => ProductProvider(null, []),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (context, auth, previous) => Orders(
                auth.token,auth.userId, previous == null ? [] : previous.items),
            create: null,
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
//          ChangeNotifierProvider.value(
//            value: Orders(),
//          ),
        ],
        child: Consumer<Auth>(
          builder: (context, authData, child) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.pink,
            ),
            home: authData.isAuth ? ProductsScreen() : FutureBuilder(future: authData.isUserLoggedIn(),builder: (context,authSnapshot) => authSnapshot.connectionState == ConnectionState.done ? AuthScreen() : false,),
            routes: {
//          '/'  :(context) => AuthScreen(),
              ProductDetailsScreen.routeName: (context) =>
                  ProductDetailsScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrderScreen.routeName: (context) => OrderScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              AddItemScreen.routeName: (context) => AddItemScreen(),
            },
          ),
        ));
  }
}
