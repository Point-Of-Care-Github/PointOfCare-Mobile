import 'package:flutter/material.dart';
import '../widgets/profileData.dart';
import '../widgets/Drawer.dart';
import '../screens/editProfile.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile-screen';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          //header

          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 4),
              child: IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.black,
                onPressed: () => scaffoldKey.currentState!.openDrawer(),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 60, top: 17.0),
              child: const Align(
                  alignment: Alignment.topLeft,
                  child:
                      Image(image: AssetImage('assets/images/leftLogo.png'))),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              //margin: const EdgeInsets.only(top: 15, right: 15),
              child: const Image(
                image: AssetImage('assets/images/profileEclipse.png'),
              ),
            ),
          ),

          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: SafeArea(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: ProfileData(),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 40, top: 130),
                child: Text(
                  'Profile',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 200, top: 130),
                child: IconButton(
                  icon: const Icon(Icons.edit_note_sharp),
                  color: Color(0xFF8587DC),
                  iconSize: 35,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
