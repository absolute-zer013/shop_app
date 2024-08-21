//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers and Models
import '../providers/cart.dart';
import '../providers/orders.dart';

class OrderButton extends StatefulWidget {
  final Cart cart;

  OrderButton(
    this.cart,
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
    var _loading = false;
    return TextButton(
      onPressed: (cart.totalAmount <= 0 || _loading)
          ? null
          : () async {
              setState(() {
                _loading = true;
              });
              await orders.addOrder(
                cart.items.values.toList(),
                cart.totalAmount,
              );
              cart.clear();
              setState(() {
                _loading = false;
              });
              showAlertDialog(context);
            },
      child: _loading ? CircularProgressIndicator() : Text('Order Now'),
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
