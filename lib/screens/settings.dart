import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  static const routeName = '/setting-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text(
        'Setting',
        style: TextStyle(fontSize: 50),
      )),
    );
  }
}
