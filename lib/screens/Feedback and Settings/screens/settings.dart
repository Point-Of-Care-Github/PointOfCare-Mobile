import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/auth.dart';

class Setting extends StatelessWidget {
  static const routeName = '/setting-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ElevatedButton(
        child: Text("Log Out"),
        onPressed: () {
          Provider.of<Auth>(context, listen: false).logout();
        },
      )),
    );
  }
}
