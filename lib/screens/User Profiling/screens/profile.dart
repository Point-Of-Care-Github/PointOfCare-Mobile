import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/doctor.dart';
import 'package:test/providers/auth.dart';
import 'package:test/providers/patient.dart';
import 'package:test/screens/User%20Profiling/screens/editProfile.dart';
import '../../../providers/radiologist.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile-screen';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
    var type;
    if (user.role == 'Doctor') {
      type = Provider.of<Doctor>(context).getDoctor(user.userId!);
    } else if (user.role == 'Patient') {
      type = Provider.of<Patient>(context).getPatient(user.userId!);
    } else {
      type = Provider.of<Radiologist>(context).getRadiologist(user.userId!);
    }
    print(type.gender);
    final role = user.role;
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: role == 'Doctor'
              ? deviceSize.height * 1.2
              : deviceSize.height / 1.1,
          child: Stack(
            children: <Widget>[
              //header
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: const Image(
                    image: AssetImage('assets/images/profileEclipse.png'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: deviceSize.height * 0.07,
                  left: deviceSize.width * 0.07,
                ),
                child: CupertinoNavigationBarBackButton(
                  color: const Color(0xFF8587DC),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 26.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: deviceSize.height * 0.01,
                          left: deviceSize.width * 0.13,
                        ),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: deviceSize.height * 0.02,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit_note_sharp),
                          color: Color(0xFF8587DC),
                          iconSize: 35,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditProfile()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  //margin: EdgeInsets.only(top: deviceSize.height * 0.12),
                  width: deviceSize.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(type.image!),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.account_circle_outlined,
                            color: Color(0xFF8587dc),
                            size: deviceSize.width * 0.07,
                          ),
                          Container(
                            width: deviceSize.width * 0.6,
                            margin:
                                EdgeInsets.only(left: deviceSize.width * 0.04),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                  fontSize: deviceSize.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                              initialValue: user.username,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.email_outlined,
                            color: Color(0xFF8587dc),
                            size: deviceSize.width * 0.07,
                          ),
                          Container(
                            width: deviceSize.width * 0.6,
                            margin:
                                EdgeInsets.only(left: deviceSize.width * 0.04),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  fontSize: deviceSize.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                              initialValue: user.userEmail,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.group_outlined,
                            color: Color(0xFF8587dc),
                            size: deviceSize.width * 0.07,
                          ),
                          Container(
                            width: deviceSize.width * 0.6,
                            margin:
                                EdgeInsets.only(left: deviceSize.width * 0.04),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                labelStyle: TextStyle(
                                  fontSize: deviceSize.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                              initialValue: type.gender,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.phone_outlined,
                            color: Color(0xFF8587dc),
                            size: deviceSize.width * 0.07,
                          ),
                          Container(
                            width: deviceSize.width * 0.6,
                            margin:
                                EdgeInsets.only(left: deviceSize.width * 0.04),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Contact',
                                labelStyle: TextStyle(
                                  fontSize: deviceSize.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                              initialValue: type.contact,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                      if (role == 'Patient' || role == 'Radiologist')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.group_outlined,
                              color: Color(0xFF8587dc),
                              size: deviceSize.width * 0.07,
                            ),
                            Container(
                              width: deviceSize.width * 0.6,
                              margin: EdgeInsets.only(
                                  left: deviceSize.width * 0.04),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  labelStyle: TextStyle(
                                    fontSize: deviceSize.width * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                                initialValue: type.age,
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                      if (role == 'Doctor')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.app_registration_rounded,
                              color: Color(0xFF8587dc),
                              size: deviceSize.width * 0.07,
                            ),
                            Container(
                              width: deviceSize.width * 0.6,
                              margin: EdgeInsets.only(
                                  left: deviceSize.width * 0.04),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Specialization',
                                  labelStyle: TextStyle(
                                    fontSize: deviceSize.width * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                                initialValue: type.specialization,
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                      if (role == 'Doctor')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.app_registration_rounded,
                              color: Color(0xFF8587dc),
                              size: deviceSize.width * 0.07,
                            ),
                            Container(
                              width: deviceSize.width * 0.6,
                              margin: EdgeInsets.only(
                                  left: deviceSize.width * 0.04),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  labelStyle: TextStyle(
                                    fontSize: deviceSize.width * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                                initialValue: type.description,
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                      if (user.role == 'Doctor')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.badge,
                              color: Color(0xFF8587dc),
                              size: deviceSize.width * 0.07,
                            ),
                            Container(
                              width: deviceSize.width * 0.6,
                              margin: EdgeInsets.only(
                                  left: deviceSize.width * 0.04),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Experience',
                                  labelStyle: TextStyle(
                                    fontSize: deviceSize.width * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                                initialValue: type.experience,
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                      if (user.role == 'Doctor')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.money,
                              color: Color(0xFF8587dc),
                              size: deviceSize.width * 0.07,
                            ),
                            Container(
                              width: deviceSize.width * 0.6,
                              margin: EdgeInsets.only(
                                  left: deviceSize.width * 0.04),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Fees',
                                  labelStyle: TextStyle(
                                    fontSize: deviceSize.width * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                                initialValue: type.fees,
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                      if (user.role == 'Doctor')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.watch_later_outlined,
                              color: Color(0xFF8587dc),
                              size: deviceSize.width * 0.07,
                            ),
                            Container(
                              width: deviceSize.width * 0.6,
                              margin: EdgeInsets.only(
                                  left: deviceSize.width * 0.04),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Time',
                                  labelStyle: TextStyle(
                                    fontSize: deviceSize.width * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                                initialValue: type.time,
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     Icon(
                      //       Icons.watch_later_outlined,
                      //       color: Color(0xFF8587dc),
                      //       size: deviceSize.width * 0.07,
                      //     ),
                      //     Container(
                      //       width: deviceSize.width * 0.6,
                      //       margin:
                      //           EdgeInsets.only(left: deviceSize.width * 0.04),
                      //       child: TextFormField(
                      //         decoration: InputDecoration(
                      //           labelText: 'Time',
                      //           labelStyle: TextStyle(
                      //             fontSize: deviceSize.width * 0.045,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //         style: TextStyle(
                      //           fontSize: deviceSize.width * 0.04,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //         initialValue: type.age,
                      //         readOnly: true,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     Icon(
                      //       Icons.watch_later_outlined,
                      //       color: Color(0xFF8587dc),
                      //       size: deviceSize.width * 0.07,
                      //     ),
                      //     Container(
                      //       width: deviceSize.width * 0.6,
                      //       margin:
                      //           EdgeInsets.only(left: deviceSize.width * 0.04),
                      //       child: TextFormField(
                      //         decoration: InputDecoration(
                      //           labelText: 'Time',
                      //           labelStyle: TextStyle(
                      //             fontSize: deviceSize.width * 0.045,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //         style: TextStyle(
                      //           fontSize: deviceSize.width * 0.04,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //         initialValue: type.age,
                      //         readOnly: true,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     Icon(
                      //       Icons.watch_later_outlined,
                      //       color: Color(0xFF8587dc),
                      //       size: deviceSize.width * 0.07,
                      //     ),
                      //     Container(
                      //       width: deviceSize.width * 0.6,
                      //       margin:
                      //           EdgeInsets.only(left: deviceSize.width * 0.04),
                      //       child: TextFormField(
                      //         decoration: InputDecoration(
                      //           labelText: 'Time',
                      //           labelStyle: TextStyle(
                      //             fontSize: deviceSize.width * 0.045,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //         style: TextStyle(
                      //           fontSize: deviceSize.width * 0.04,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //         initialValue: type.age,
                      //         readOnly: true,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     Icon(
                      //       Icons.watch_later_outlined,
                      //       color: Color(0xFF8587dc),
                      //       size: deviceSize.width * 0.07,
                      //     ),
                      //     Container(
                      //       width: deviceSize.width * 0.6,
                      //       margin:
                      //           EdgeInsets.only(left: deviceSize.width * 0.04),
                      //       child: TextFormField(
                      //         decoration: InputDecoration(
                      //           labelText: 'Time',
                      //           labelStyle: TextStyle(
                      //             fontSize: deviceSize.width * 0.045,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //         style: TextStyle(
                      //           fontSize: deviceSize.width * 0.04,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //         initialValue: type.age,
                      //         readOnly: true,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     Icon(
                      //       Icons.watch_later_outlined,
                      //       color: Color(0xFF8587dc),
                      //       size: deviceSize.width * 0.07,
                      //     ),
                      //     Container(
                      //       width: deviceSize.width * 0.6,
                      //       margin:
                      //           EdgeInsets.only(left: deviceSize.width * 0.04),
                      //       child: TextFormField(
                      //         decoration: InputDecoration(
                      //           labelText: 'Time',
                      //           labelStyle: TextStyle(
                      //             fontSize: deviceSize.width * 0.045,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //         style: TextStyle(
                      //           fontSize: deviceSize.width * 0.04,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //         initialValue: type.age,
                      //         readOnly: true,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
