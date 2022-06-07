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

  void addOrder(List<CartItem> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    final url = Uri.parse(
        'https://shop-app-6a133-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amount': total,
            'dateTime': timeStamp.toIso8601String(),
            'products': cartProducts.map(
              (cp) => {
                'id': cp.id,
                'title': cp.title,
                'quantity': cp.quantity,
                'price': cp.price,
              },
            ),
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
}
