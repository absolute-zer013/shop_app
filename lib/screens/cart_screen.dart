import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//providers
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';

//Widgets
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(children: <Widget>[
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total :',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    '\$${cart.totalAmount}',
                    style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.headline6.color,
                      fontFamily: 'Lato',
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                OrderButton(cart),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (ctx, i) => CartItem(
              cart.items.values.toList()[i].id,
              cart.items.values.toList()[i].price,
              cart.items.values.toList()[i].quantity,
              cart.items.values.toList()[i].title,
              cart.items.keys.toList()[i],
            ),
          ),
        ),
      ]),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;

  OrderButton(
    @required this.cart,
  );

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(
      context,
      listen: false,
    );
    return TextButton(
      onPressed: cart.totalAmount <= 0
          ? null
          : () {
              orders.addOrder(
                cart.items.values.toList(),
                cart.totalAmount,
              );
              cart.clear();
              showAlertDialog(context);
            },
      child: Text('Order Now'),
      style: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
    );
  }

  void showAlertDialog(context) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Order Confirm'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You can view your list of order in the order menu'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
}
