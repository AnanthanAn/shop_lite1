import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItemTile({this.id, this.title, this.quantity, this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('₹$price'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: ${quantity * price}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
