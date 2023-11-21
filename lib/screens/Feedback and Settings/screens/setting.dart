// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/providers/patient_profile.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/providers/auth_services.dart';
import 'package:test/screens/Main/screens/tabScreen.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final user = Provider.of<UserProvider>(context).user;
    String img = '';
    if (user.role == 'Doctor') {
      img = Provider.of<DoctorProvider>(context).doctor.image;
    }
    if (user.role == 'Patient') {
      img = Provider.of<PatientProvider>(context).patient.image;
    }
    Future<bool?> _showConfirmationDialog(BuildContext context) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Deactivate Account',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content:
                const Text('Are you sure you want to deactivate your account?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );
    }

    final AuthService authService = AuthService();

    void deleteAccount(String email) async {
      // ignore: use_build_context_synchronously
      authService.deleteAccount(
        context: context,
        email: email,
      );
    }

    return Material(
      child: Stack(
        children: [
          const Image(
            image: AssetImage('assets/images/eclipse.png'),
          ),

          // Title
          Container(
            margin: EdgeInsets.only(
              top: deviceSize.height * 0.09,
              left: deviceSize.width * 0.2,
            ),
            child: Text(
              'Settings',
              style: TextStyle(
                color: const Color(0xff200E32).withOpacity(0.8),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: deviceSize.height * 0.09,
              left: deviceSize.width * 0.05,
            ),
            child: CupertinoNavigationBarBackButton(
              color: const Color(0xFF8587DC),
              onPressed: () {
                Navigator.of(context).pushNamed(TabsScreen.routeName);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: deviceSize.width * 0.05,
              vertical: deviceSize.height * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: deviceSize.height * 0.13),
                buildListTile(
                  context: context,
                  icon: CupertinoIcons.person,
                  text: "Profile",
                  onTap: () {},
                  deviceSize: deviceSize,
                  textScaleFactor: textScaleFactor,
                ),
                SizedBox(height: deviceSize.height * 0.02),
                buildListTile(
                  context: context,
                  icon: CupertinoIcons.question_circle,
                  text: "FAQ",
                  onTap: () {},
                  deviceSize: deviceSize,
                  textScaleFactor: textScaleFactor,
                ),
                SizedBox(height: deviceSize.height * 0.02),
                buildListTile(
                  context: context,
                  icon: Icons.privacy_tip_outlined,
                  text: "Feedback",
                  onTap: () {},
                  deviceSize: deviceSize,
                  textScaleFactor: textScaleFactor,
                ),
                SizedBox(height: deviceSize.height * 0.02),
                buildListTile(
                  context: context,
                  icon: Icons.settings_suggest_outlined,
                  text: "General",
                  onTap: () {},
                  deviceSize: deviceSize,
                  textScaleFactor: textScaleFactor,
                ),
                SizedBox(height: deviceSize.height * 0.02),
                buildListTile(
                  context: context,
                  icon: Icons.info_outline_rounded,
                  text: "About Us",
                  onTap: () {},
                  deviceSize: deviceSize,
                  textScaleFactor: textScaleFactor,
                ),
                SizedBox(height: deviceSize.height * 0.02),
                buildListTile(
                  context: context,
                  icon: Icons.close,
                  text: "Deactivate Account",
                  onTap: () async {
                    final confirmed = await _showConfirmationDialog(context);
                    if (confirmed == true) {
                      deleteAccount(user.email);
                    }
                  },
                  deviceSize: deviceSize,
                  textScaleFactor: textScaleFactor,
                ),
                Divider(height: deviceSize.height * 0.04),
                buildListTile(
                  context: context,
                  icon: Icons.logout,
                  text: "Log Out",
                  onTap: () {},
                  deviceSize: deviceSize,
                  textScaleFactor: textScaleFactor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required Size deviceSize,
    required double textScaleFactor,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(deviceSize.width * 0.03),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: deviceSize.width * 0.1,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20 * textScaleFactor,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
