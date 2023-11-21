import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/doctor.dart';
import 'package:test/providers/auth.dart';
import 'package:test/providers/patient.dart';
import '../../../providers/radiologist.dart';
import '../widgets/profileData.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile-screen';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
    final type;

    if (user.role == 'Doctor') {
      type = Provider.of<Doctor>(context).getDoctor(user.userId!);
    } else if (user.role == 'Patient') {
      type = Provider.of<Patient>(context).getPatient(user.userId!);
    } else {
      type = Provider.of<Radiologist>(context).getRadiologist(user.userId!);
    }
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
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
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 26.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: const Icon(Icons.edit_note_sharp),
                      color: Color(0xFF8587DC),
                      iconSize: 35,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
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
                        margin: EdgeInsets.only(left: deviceSize.width * 0.04),
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
                  Container(
                    margin: EdgeInsets.only(
                        top: deviceSize.height * 0.01,
                        left: deviceSize.width * 0.015),
                    child: Row(
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
                                fontFamily: 'League Spartan',
                                fontSize: deviceSize.width * 0.045,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: deviceSize.width * 0.04,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'League Spartan',
                            ),
                            initialValue: user.userEmail,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: deviceSize.height * 0.01,
                        left: deviceSize.width * 0.015),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.group,
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
                                fontFamily: 'League Spartan',
                                fontSize: deviceSize.width * 0.045,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: deviceSize.width * 0.04,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'League Spartan',
                            ),
                            initialValue: type.gender,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: deviceSize.height * 0.01,
                        left: deviceSize.width * 0.015),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone_enabled,
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
                                fontFamily: 'League Spartan',
                                fontSize: deviceSize.width * 0.045,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: deviceSize.width * 0.04,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'League Spartan',
                            ),
                            initialValue: type.contact,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (user.role == 'Patient')
                    Container(
                      margin: EdgeInsets.only(
                          top: deviceSize.height * 0.01,
                          left: deviceSize.width * 0.015),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.group,
                            color: Color(0xFF8587dc),
                            size: deviceSize.width * 0.07,
                          ),
                          Container(
                            width: deviceSize.width * 0.6,
                            margin:
                                EdgeInsets.only(left: deviceSize.width * 0.04),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Age',
                                labelStyle: TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: deviceSize.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.04,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'League Spartan',
                              ),
                              initialValue: type.age,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Container(
                      margin: EdgeInsets.only(
                          top: deviceSize.height * 0.01,
                          left: deviceSize.width * 0.015),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.app_registration_rounded,
                            color: Color(0xFF8587dc),
                            size: deviceSize.width * 0.07,
                          ),
                          Container(
                            width: deviceSize.width * 0.6,
                            margin:
                                EdgeInsets.only(left: deviceSize.width * 0.04),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Specialization',
                                labelStyle: TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: deviceSize.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.04,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'League Spartan',
                              ),
                              initialValue: type.specialization,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Container(
                      margin: EdgeInsets.only(
                          top: deviceSize.height * 0.01,
                          left: deviceSize.width * 0.015),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.app_registration_rounded,
                            color: Color(0xFF8587dc),
                            size: deviceSize.width * 0.07,
                          ),
                          Container(
                            width: deviceSize.width * 0.6,
                            margin:
                                EdgeInsets.only(left: deviceSize.width * 0.04),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Description',
                                labelStyle: TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: deviceSize.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.04,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'League Spartan',
                              ),
                              initialValue: type.description,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Container(
                      margin: EdgeInsets.only(
                          top: deviceSize.height * 0.01,
                          left: deviceSize.width * 0.015),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.badge,
                            color: Color(0xFF8587dc),
                            size: deviceSize.width * 0.07,
                          ),
                          Container(
                            width: deviceSize.width * 0.6,
                            margin:
                                EdgeInsets.only(left: deviceSize.width * 0.04),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Experience',
                                labelStyle: TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: deviceSize.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.04,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'League Spartan',
                              ),
                              initialValue: type.experience,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
