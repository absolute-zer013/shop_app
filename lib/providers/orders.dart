//package
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//provider
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get orders {
    return [..._order];
  }

  //Adding order to cart function
  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    final url = Uri.parse(
        'https://shop-app-6a133-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amount': total,
            'dateTime': timeStamp.toIso8601String(),
            'products': cartProducts
                .map(
                  (cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  },
                )
                .toList(),
          },
        ),
      );
      _order.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timeStamp,
          products: cartProducts,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
    ;
  }

  //Getting order from firebase database
  Future<void> fetchAndSetOrder() async {
    final url = Uri.parse(
        'https://shop-app-6a133-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json');

    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) return;
    try {
      extractedData.forEach(
        (orderId, orderData) {
          loadedOrders.add(
            OrderItem(
              id: orderId,
              amount: orderData['amount'],
              products: (orderData['products'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      quantity: item['quantity'],
                      price: item['price'],
                    ),
                  )
                  .toList(),
              dateTime: DateTime.parse(
                orderData['dateTime'],
              ),
            ),
          );
        },
      );
      _order = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
