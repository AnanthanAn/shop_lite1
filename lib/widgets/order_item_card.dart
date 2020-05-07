import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:shoplite1/models/Providers/orders.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem orderItem;

  OrderItemCard({@required this.orderItem});

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  var _dropDown = false;

  @override
  Widget build(BuildContext context) {
    print('oreder item was built');
    print(widget.orderItem.id);
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('₹${widget.orderItem.total}'),
            subtitle: Text(
              DateFormat('dd-MM-yyyy hh:mm').format(widget.orderItem.time),
            ),
            trailing: IconButton(
                icon: _dropDown?Icon(Icons.expand_less):Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _dropDown = !_dropDown;
                  });
                }),
          ),
          if (_dropDown)
            Container(
              height: min(widget.orderItem.products.length * 20.0 + 10.0, 100),
              child: ListView(
                children: widget.orderItem.products
                    .map((item) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${item.title}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${item.quantity} x ₹${item.price}')
                            ],
                          ),
                    ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
