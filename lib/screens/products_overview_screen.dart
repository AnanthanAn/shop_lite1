import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/product_provider.dart';
import 'package:shoplite1/screens/product_details_screen.dart';
import 'package:shoplite1/widgets/product_item.dart';


class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final prodProvider = Provider.of<ProductProvider>(context);
    final prodItems = prodProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: GridView.builder(padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 2),
        itemBuilder: (context, index) => GestureDetector(onTap: () {
          Navigator.pushNamed(context, ProductDetailsScreen.routeName,arguments: prodItems[index].id);
        },
          child: ProductItem(
            id: prodItems[index].id,
            title: prodItems[index].title,
            imageUrl: prodItems[index].imageUrl,
          ),
        ),
        itemCount: prodItems.length,
      ),
    );
  }
}
