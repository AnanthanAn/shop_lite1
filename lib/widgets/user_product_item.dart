import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
      {@required this.id, @required this.title, @required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
