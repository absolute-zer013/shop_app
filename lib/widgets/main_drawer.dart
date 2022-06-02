import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../screens/user_product_screen.dart';

class MainDrawer extends StatelessWidget {
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
          ListTile(
            title: Text(
              "Shop",
              style: TextStyle(fontFamily: 'Arton'),
            ),
            leading: Icon(
              Icons.shop,
              color: Colors.deepOrange,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              "Orders",
              style: TextStyle(fontFamily: 'Arton'),
            ),
            leading: Icon(
              Icons.payment,
              color: Colors.deepOrange,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              "Manage Products",
              style: TextStyle(fontFamily: 'Arton'),
            ),
            leading: Icon(
              Icons.edit,
              color: Colors.deepOrange,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
