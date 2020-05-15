import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/cart.dart';
import 'package:shoplite1/models/Providers/product_provider.dart';
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
  var _isInit = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    //this will run after context is available so making sure that this will run only once
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<ProductProvider>(context, listen: false)
            .fetchProducts().catchError((error){
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Oops!'),
                content: Text(error.toString()),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pop(ctx), child: Text('OK'))
                ],
              ));
        })
            .then((_) {
          //then will wait for the async funtion to complete
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Oops!'),
                  content: Text('Something went wrong'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.pop(ctx), child: Text('OK'))
                  ],
                ));
      }
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: <Widget>[
          Consumer<Cart>(
            //Consumer is used when we want to listen to changes and rebuild only a certain part
            builder: (_, cart, _2) => Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
              value: cart.itemsCount.toString(),
              color: Colors.lightGreen,
            ),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Loading...',
              ),
            )
          : ProductGrid(
              favOnly: favOnly,
            ),
      drawer: AppDrawer(),
    );
  }
}
