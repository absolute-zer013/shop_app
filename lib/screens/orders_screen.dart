//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//providers
import '../providers/orders.dart' show Orders;
//widgets
import '../widgets/order_item.dart';
import '../widgets/main_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/ordersscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        drawer: MainDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrder(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('ada error'),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, orderData, child) {
                  return ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) => OrderItem(
                      orderData.orders[i],
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
