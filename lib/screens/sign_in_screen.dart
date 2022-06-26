import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/sign-in';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: Colors.deepOrange,
            child: Image.asset('assets/images/Shopee_logo_PNG14.png'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
