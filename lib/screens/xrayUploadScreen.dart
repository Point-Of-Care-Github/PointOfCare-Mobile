import 'package:flutter/material.dart';
import '../widgets/xrayupload.dart';

class XrayUploadScreen extends StatelessWidget {
  static const routeName = '/xray-upload-screen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        const Image(
          image: AssetImage('assets/images/eclipse.png'),
        ),
        Container(
          margin: const EdgeInsets.only(left: 0.0, top: 70.0, right: 25.0),
          child: const Align(
              alignment: Alignment.topRight,
              child: Image(image: AssetImage('assets/images/authLogo.png'))),
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
                    child: const XrayUpload(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 73, left: 40),
          child: SizedBox(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
              ),
              color: Color(0xFF8587DC),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    ));
  }
}
