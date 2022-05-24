import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/products_overview_screen.dart';

import '../screens/orders_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        Icons.shopping_bag,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        tapHandler();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          //alternative solution
          // AppBar(
          //   title: Text('Hello Friend!'),
          //   automaticallyImplyLeading: false,
          // ),
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Shopee',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Divider(),
          buildListTile(
            "Shop",
            Icons.shop,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          buildListTile(
            "Orders",
            Icons.payment,
            () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
