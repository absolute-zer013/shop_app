import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _desciptionFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNode.dispose();
    _desciptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product Description',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_desciptionFocusNode);
                  },
                ),
                // Expanded(
                //   child: TextFormField(
                //     decoration: InputDecoration(labelText: 'Image URL'),
                //     keyboardType: TextInputType.url,
                //     textInputAction: TextInputAction.done,
                //     controller: _imageUrlController,
                //     onEditingComplete: () {
                //       setState(
                //         () {},
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
