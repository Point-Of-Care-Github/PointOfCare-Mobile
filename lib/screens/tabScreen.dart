import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'homeScreen.dart';
import 'profile.dart';
import 'settings.dart';
import '../widgets/Drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tab-screen';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 1;
  static List<Widget> _widgetOptions = <Widget>[
    Profile(),
    HomeScreen(),
    Setting(),
  ];
  List<String> titles = [
    'Profile',
    'Home',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Material(
        elevation: 30,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8),
              child: GNav(
                rippleColor: Color.fromARGB(255, 224, 224, 224),
                hoverColor: Color.fromARGB(255, 245, 245, 245),
                activeColor: Color.fromRGBO(53, 60, 85, 1),
                iconSize: 30,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Color.fromARGB(255, 245, 245, 245),
                color: Color(0xFF696969),
                tabs: [
                  GButton(
                    icon: Icons.person,
                    iconActiveColor: Colors.white,
                    backgroundColor: Color(0xFF7F80D2),
                  ),
                  GButton(
                    icon: Icons.home,
                    iconActiveColor: Colors.white,
                    backgroundColor: Color(0xFF7F80D2),
                  ),
                  GButton(
                    icon: Icons.settings,
                    iconActiveColor: Colors.white,
                    backgroundColor: Color(0xFF7F80D2),
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
