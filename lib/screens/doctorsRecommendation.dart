import 'package:flutter/material.dart';
import 'package:test/widgets/Drawer.dart';
import 'package:test/widgets/doctorsGrid.dart';
import '../widgets/reportList.dart';

class DoctorRecommendationScreen extends StatelessWidget {
  static const routeName = '/report-screen';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //header
          const Image(
            image: AssetImage('assets/images/topWaves1.png'),
          ),

          Container(
            margin: EdgeInsets.only(left: 100, top: 73),
            width: deviceSize.width * 0.55,
            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  labelStyle: TextStyle(
                    fontFamily: 'League Spartan',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                  prefixIcon: Icon(Icons.search_outlined),
                  prefixIconColor: Colors.black,
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'League Spartan',
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50, top: 160),
            child: Text(
              'Available Doctors',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            // ignore: sized_box_for_whitespace
            child: Container(
              height: deviceSize.height * 0.9,
              width: deviceSize.width,
              margin: EdgeInsets.only(top: 180),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: DoctorsGrid(),
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
      ),
    );
  }
}
