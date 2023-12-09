import 'package:flutter/material.dart';
import 'package:test/screens/Diagnosis/widgets/xrayForm.dart';
import 'package:test/widgets/backButton.dart';

class XrayDiagnosis extends StatelessWidget {
  static const routeName = '/xray-diagnosis-screen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          const Image(
            image: AssetImage('assets/images/eclipse.png'),
          ),
          SingleChildScrollView(
            // ignore: sized_box_for_whitespace
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: SafeArea(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: const XrayForm(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          backButton(context)
        ],
      ),
    );
  }
}
