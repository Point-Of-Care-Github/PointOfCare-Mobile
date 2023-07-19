import 'package:flutter/material.dart';
import '../widgets/nearDoctorList.dart';

class NearbyDoctors extends StatelessWidget {
  static const routeName = '/nearby-doctors-screen';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color(0xFF8587DC).withOpacity(0.2),
        child: Stack(
          children: <Widget>[
            // Header
            Image(
              image: AssetImage('assets/images/topWaves1.png'),
            ),

            Container(
              margin: EdgeInsets.only(
                left: 0.0,
                top: deviceSize.height * 0.09,
                right: deviceSize.width * 0.05,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Image(
                  image: AssetImage('assets/images/authLogo.png'),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.09,
                left: deviceSize.width * 0.08,
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
            Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.2,
                left: deviceSize.width * 0.15,
              ),
              child: Text(
                'Doctors Recommendation',
                style: TextStyle(
                    color: Color(0xff200E32).withOpacity(0.8),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
            // NearDoctorList
            Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.25),
              child: NearDoctorList(),
            ),
          ],
        ),
      ),
    );
  }
}
