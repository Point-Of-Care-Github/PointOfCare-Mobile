import 'package:flutter/material.dart';
import 'package:test/screens/Diagnosis/widgets/symptomsForm.dart';
import 'package:test/widgets/backButton.dart';
import 'uploadScreen.dart';

class SymptomsScreen extends StatelessWidget {
  static const routeName = '/symptoms-screen';
  final user;
  final dis;
  SymptomsScreen(this.user, this.dis);

  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          const Image(
            image: AssetImage('assets/images/eclipse.png'),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 0.0,
              top: 50,
              right: deviceSize.width * 0.0467,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                'assets/images/authLogo.png',
                height: 80,
                width: 80,
              ),
            ),
          ),
          SymptomsForm(user, dis),
          backButton(context)
        ],
      ),
    );
  }
}
