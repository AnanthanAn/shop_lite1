import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/cart.dart';
import 'package:shoplite1/models/product.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);

    return Consumer<Product>(
      builder: (ctx, product, child) => GridTile(
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
              color: Theme.of(context).primaryColor,
              icon: product.isFav
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onPressed: () {
                product.toggleFavourite();
              }),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(
                  prodId: product.id,
                  title: product.title,
                  price: product.price);
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Item added to cart!')));
            },
          ),
        ),
      ),
    );
  }
}
