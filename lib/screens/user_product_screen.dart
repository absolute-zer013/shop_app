import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//provider
import '../providers/products.dart';

//widgets
import '../widgets/user_product.dart';
import '../widgets/main_drawer.dart';

//screen
import '../screens/edit_product.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Your Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                productData.items[i].title,
                productData.items[i].imageUrl,
                productData.items[i].id,
              ),
              Divider(
                thickness: 1,
              ),
            ],
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
