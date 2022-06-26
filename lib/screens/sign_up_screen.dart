import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  static const routeName = '/sign-up';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign Up'),
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
