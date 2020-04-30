import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/product_provider.dart';
import 'package:shoplite1/models/product.dart';
import 'package:shoplite1/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final bool favOnly;
//  final String title;
//  final String imageUrl;
//
  ProductItem({this.favOnly,});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    final prodItems = products.favItems;
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailsScreen.routeName,
              arguments: prodItems[index].id);
        },
        child: ChangeNotifierProvider.value(
          value: prodItems[
              index], //Just an alternate for ChangeNotifier with create,no change in working, can use when we dont care about context

          child: GridTile(
            child: Image.network(
              prodItems[index].imageUrl,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(
                prodItems[index].title,
                textAlign: TextAlign.center,
              ),
              leading: IconButton(
                  color: Theme.of(context).primaryColor,
                  icon: prodItems[index].isFav
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    prodItems[index].toggleFavourite();
                  }),
              trailing: Icon(Icons.shopping_cart),
            ),
          ),
        ),
      ),
      itemCount: prodItems.length,
    );
  }
}
