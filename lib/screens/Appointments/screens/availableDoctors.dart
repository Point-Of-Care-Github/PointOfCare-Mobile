// ignore_for_file: file_names

import 'package:provider/provider.dart';
import 'package:test/providers/auth.dart';
import 'package:test/providers/doctor.dart';
import 'package:test/screens/Doctor%20Recommendation/widgets/doctorsGrid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/screens/Doctor%20Recommendation/screens/searchBar.dart';

class AvailableDoctorsScreen extends StatefulWidget {
  static const routeName = '/available-doctors';
  const AvailableDoctorsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AvailableDoctorsScreenState createState() => _AvailableDoctorsScreenState();
}

class _AvailableDoctorsScreenState extends State<AvailableDoctorsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<Doctor>(context, listen: false).fetchDoctors().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    Provider.of<Auth>(context, listen: false).fetchUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                // Header Image
                const Image(
                  image: AssetImage('assets/images/topWaves1.png'),
                ),

                // SearchBar
                Search(
                  leftMargin: deviceSize.width * 0.18,
                  topMargin: deviceSize.height * 0.08,
                  width: deviceSize.width * 0.7,
                  color:
                      const Color.fromARGB(255, 219, 207, 207).withOpacity(0.2),
                ),

                // Title
                Container(
                  margin: EdgeInsets.only(
                    top: deviceSize.height * 0.19,
                    left: deviceSize.width * 0.1,
                  ),
                  child: Text(
                    'Appointment',
                    style: TextStyle(
                      color: const Color(0xff200E32).withOpacity(0.8),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                ),

                // Back Button
                Container(
                  margin: EdgeInsets.only(
                    left: deviceSize.width * 0.05,
                  ),
                  child: CupertinoNavigationBarBackButton(
                    color: const Color(0xFF8587DC),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // Doctor grid
              ],
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : DoctorsGrid(),
          ],
        ),
      ),
    );
  }
}
