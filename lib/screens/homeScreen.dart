import 'package:flutter/material.dart';
import '../widgets/Drawer.dart';
import '../widgets/homeBanner.dart';
import '../widgets/homeGrid.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          const Image(
            image: AssetImage('assets/images/topWaves1.png'),
          ),

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
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(top: 15, right: 15),
                child: CircleAvatar(
                    // backgroundImage: NetworkImage(products[1].pic.toString()),
                    ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 140, left: 40),
            child: Text(
              'Hello,',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40, top: 165),
            child: Text(''
                // products[1].name.toString() + '!👋',
                // style: TextStyle(
                //     fontFamily: 'Poppins',
                //     fontSize: 22,
                //     fontWeight: FontWeight.bold),
                ),
          ),

          Container(
            margin: EdgeInsets.only(left: 40, top: 220),
            width: deviceSize.width * 0.8,
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

          HomeBanner(),
          Container(
            margin: EdgeInsets.only(top: 430, left: 40),
            child: Text(
              'What do you need?',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 21,
                  fontWeight: FontWeight.w500),
            ),
          ),
          HomeGrid(),
        ],
      ),
    );
  }
}
