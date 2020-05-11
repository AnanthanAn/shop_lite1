import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/orders.dart';
import 'package:shoplite1/widgets/order_item_card.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.done) {
              print('done');
              print(Provider.of<Orders>(context, listen: false).noOrders);
              if(!dataSnapshot.hasData){
                return Center(child: Text('Sorry you don\'t have any orders yet'),);
              }
              return Consumer<Orders>(
                builder: (context, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, idx) => OrderItemCard(
                    orderItem: orderData.items[idx],
                  ),
                  itemCount: orderData.items.length,
                ),
              );
            } else if (dataSnapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Text('Oops :)'),
            );
          }),
    );
  }
}
