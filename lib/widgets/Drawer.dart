import 'package:flutter/material.dart';
import 'package:test/screens/tabScreen.dart';
import 'package:test/screens/settings.dart';
import '../models/users.dart';

import 'package:provider/provider.dart';

import '../screens/reportScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Users>(context);
    final products = productsData.users;
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFB9A0E6),
                    Color(0xFF8587DC),
                    Color(0xFF200E32),
                  ]),
            ),
            accountName: Text(
              products[1].name.toString(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            accountEmail: Text(
              products[1].email.toString(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(products[1].pic.toString()),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              size: 32,
              color: Color(0xFF7F80D2),
            ),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 16, fontFamily: 'League Spartan'),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(TabsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.man_sharp,
              color: Color(0xFF7F80D2),
              size: 32,
            ),
            title: Text(
              "Doctor",
              style: TextStyle(fontSize: 16, fontFamily: 'League Spartan'),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(Setting.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.inventory_sharp,
              color: Color(0xFF7F80D2),
              size: 30,
            ),
            title: Text(
              "Reports",
              style: TextStyle(fontSize: 16, fontFamily: 'League Spartan'),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ReportScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.privacy_tip_outlined,
              color: Color(0xFF7F80D2),
              size: 30,
            ),
            title: Text(
              "Terms & Condition",
              style: TextStyle(fontSize: 16, fontFamily: 'League Spartan'),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
