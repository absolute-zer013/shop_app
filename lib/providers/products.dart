import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //Getting order from firebase database
  Future<void> fetchAndSetProduct() async {
    final url = Uri.parse(
        'https://shop-app-test-db-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Product> loadedProducts = [];
    if (extractedData == null) return;
    try {
      extractedData.forEach(
        (prodId, prodData) {
          loadedProducts.add(
            Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              isFavorite: prodData['isFavorite'],
              imageUrl: prodData['imageUrl'],
            ),
          );
        },
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  //adding product function
  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://shop-app-test-db-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (onError) {
      throw onError;
    }
  }

  //edit product function
  Future<void> updateProduct(String id, Product newProduct) async {
    final proIndex = _items.indexWhere((prod) => prod.id == id);
    if (proIndex >= 0) {
      final url = Uri.parse(
          'https://shop-app-test-db-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
      await http.patch(
        url,
        body: json.encode(
          {
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            // 'isFavorite': newProduct.isFavorite,
          },
        ),
      );
      _items[proIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  //delete product function
  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://shop-app-test-db-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not Delete product.');
    }
    existingProduct = null;
  }
}
