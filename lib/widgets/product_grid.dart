import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/product_provider.dart';
import 'package:shoplite1/screens/product_details_screen.dart';
import 'package:shoplite1/widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool favOnly;
//  final String title;
//  final String imageUrl;
//
  ProductGrid({
    this.favOnly,
  });

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    final prodItems = favOnly ? products.favItems : products.items;
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

            child: ProductItem(
              id: prodItems[index].id,
              title: prodItems[index].title,
              imageUrl: prodItems[index].imageUrl,
            )),
      ),
      itemCount: prodItems.length,
    );
  }
}
