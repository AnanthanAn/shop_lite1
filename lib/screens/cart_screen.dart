import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/cart.dart';
import 'package:shoplite1/widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Padding(
              child: Row(
                children: <Widget>[
                  Text('Total'),
                  Spacer(),
                  Chip(label: Text('₹${cart.totalPrice}'))
                ],
              ),
              padding: EdgeInsets.all(10),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.itemsCount,
            itemBuilder: (ctx, index) => CartItemTile(
              id: cart.items.values.toList()[index].prodId,
              quantity: cart.items.values.toList()[index].quantity,
              title: cart.items.values.toList()[index].title,
              price: cart.items.values.toList()[index].price,
            ),
          ))
        ],
      ),
    );
  }
}
