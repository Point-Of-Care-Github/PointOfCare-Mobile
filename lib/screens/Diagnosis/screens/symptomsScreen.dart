import 'package:flutter/material.dart';
import 'package:test/screens/Diagnosis/widgets/symptomsForm.dart';
import 'uploadScreen.dart';

class SymptomsScreen extends StatelessWidget {
  static const routeName = '/symptoms-screen';
  const SymptomsScreen({super.key});

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
          SymptomsForm(),
          Container(
            margin: EdgeInsets.only(
              top: deviceSize.height * 0.0973,
              left: deviceSize.width * 0.0533,
            ),
            child: SizedBox(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: deviceSize.width * 0.08,
                ),
                color: Color(0xFF8587DC),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
