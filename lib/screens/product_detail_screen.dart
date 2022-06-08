//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//provider
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Container(
              height: 75,
              width: double.infinity,
              //color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      loadedProduct.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Arton',
                      ),
                    ),
                    Text(
                      'RM ${loadedProduct.price}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 80,
              width: double.infinity,
              //color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PRODUCT DETAILS',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 7,
                            right: 5,
                          ),
                          height: 5,
                          width: 5,
                          color: Colors.deepOrange,
                        ),
                        Text(
                          loadedProduct.description,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
