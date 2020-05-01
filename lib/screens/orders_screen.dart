import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/orders.dart';
import 'package:shoplite1/widgets/order_item_card.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) => OrderItemCard(
          orderItem: order[idx],
        ),itemCount: order.length,
      ),
    );
  }
}
