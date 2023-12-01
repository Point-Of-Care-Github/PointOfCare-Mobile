import 'package:flutter/material.dart';

class CTscanDiagnosis extends StatelessWidget {
  static const routeName = '/ctscan-diagnosis-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(child: Text('CT-Scan')),
      ),
    );
  }
}
