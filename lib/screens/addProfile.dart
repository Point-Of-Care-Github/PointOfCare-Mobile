import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test/screens/tabScreen.dart';

import '../providers/auth.dart';
import '../providers/profile.dart';
import '../widgets/MyButton.dart';

class DoctorProfile extends StatefulWidget {
  static const routeName = 'doctor-profile';
  DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  File? _image;
  TextEditingController _ageController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _specializationController = TextEditingController();
  bool _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (c) => AlertDialog(
              title: Text('An Error Occurred!'),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(c).pop();
                  },
                  child: Text('Okay'),
                )
              ],
            ));
  }

  Future getImage(bool isCamera) async {
    XFile? image;
    if (isCamera) {
      image = await ImagePicker().pickImage(
          source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    File? file = File(image!.path);
    setState(() {
      _image = file;
    });
  }

  Future<void> addData() async {
    if (_ageController.text.isEmpty ||
        _contactController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _genderController.text.isEmpty ||
        _experienceController.text.isEmpty ||
        _specializationController.text.isEmpty) {
      _showErrorDialog("Some fields are empty!");
      return;
    }
    setState(() {
      _isLoading = true;
    });

    final id = Provider.of<Auth>(context, listen: false).userId;
    try {
      Provider.of<Doctor>(context, listen: false)
          .addDoctor(Doctor(
              userId: id,
              age: _ageController.text,
              contact: _contactController.text,
              description: _descriptionController.text,
              experience: _experienceController.text,
              gender: _genderController.text,
              image: '',
              specialization: _specializationController.text))
          .then((_) {
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
        setState(() {
          _isLoading = false;
        });
      });
    } on HttpException catch (e) {
      var errorMessage = 'Authentication failed.';
      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address exists.';
      } else if (e.toString().contains("INVALID_EMAIL")) {
        errorMessage = 'This is not a valid email address.';
      } else if (e.toString().contains("WEAK_PASSWORD")) {
        errorMessage = 'This password is too weak.';
      } else if (e.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = 'Could not find a user with that email.';
      } else if (e.toString().contains("INVALID_PASSWORD")) {
        errorMessage = 'Incorrect password.';
      }
      _showErrorDialog(errorMessage);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';

      setState(() {
        _isLoading = false;
      });
    }
  }

  void addData1(String role) async {
    if (_ageController.text.isEmpty ||
        _contactController.text.isEmpty ||
        _genderController.text.isEmpty) {
      _showErrorDialog("Some fields are empty!");
      return;
    }
    setState(() {
      _isLoading = true;
    });

    final id = Provider.of<Auth>(context, listen: false).userId;
    try {
      if (role == 'Radiologist') {
        Provider.of<Radiologist>(context, listen: false)
            .addRadiologist(Radiologist(
          userId: id,
          age: _ageController.text,
          contact: _contactController.text,
          gender: _genderController.text,
          image: '',
        ))
            .then((_) {
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
          setState(() {
            _isLoading = false;
          });
        });
      } else {
        Provider.of<Patient>(context, listen: false)
            .addPatient(Patient(
          userId: id,
          age: _ageController.text,
          contact: _contactController.text,
          gender: _genderController.text,
          image: '',
        ))
            .then((_) {
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
          setState(() {
            _isLoading = false;
          });
        });
      }
    } on HttpException catch (e) {
      var errorMessage = 'Authentication failed.';
      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address exists.';
      } else if (e.toString().contains("INVALID_EMAIL")) {
        errorMessage = 'This is not a valid email address.';
      } else if (e.toString().contains("WEAK_PASSWORD")) {
        errorMessage = 'This password is too weak.';
      } else if (e.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = 'Could not find a user with that email.';
      } else if (e.toString().contains("INVALID_PASSWORD")) {
        errorMessage = 'Incorrect password.';
      }
      _showErrorDialog(errorMessage);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final route =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Doctor Profile",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        child: ClipOval(
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Text(
                                  "Choose a photo",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'League Spartan'),
                                )),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            color: Color.fromARGB(255, 247, 247, 247)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              getImage(true);
                            },
                            child: Text('Camera'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFB9A0E6)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              getImage(false);
                            },
                            child: Text('Gallery'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFB9A0E6)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          labelStyle: TextStyle(
                            fontFamily: 'League Spartan',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          prefixIconColor: Colors.black,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'League Spartan',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _contactController,
                        decoration: const InputDecoration(
                          labelText: 'Contact',
                          labelStyle: TextStyle(
                            fontFamily: 'League Spartan',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          prefixIconColor: Colors.black,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'League Spartan',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _genderController,
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          labelStyle: TextStyle(
                            fontFamily: 'League Spartan',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          prefixIconColor: Colors.black,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'League Spartan',
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      route['role'] != 'Doctor'
                          ? Container()
                          : TextFormField(
                              controller: _specializationController,
                              decoration: const InputDecoration(
                                labelText: 'Specialization',
                                labelStyle: TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                prefixIcon: Icon(Icons.account_circle_outlined),
                                prefixIconColor: Colors.black,
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'League Spartan',
                              ),
                              keyboardType: TextInputType.text,
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      route['role'] != 'Doctor'
                          ? Container()
                          : TextFormField(
                              controller: _experienceController,
                              decoration: const InputDecoration(
                                labelText: 'Experience',
                                labelStyle: TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                prefixIcon: Icon(Icons.account_circle_outlined),
                                prefixIconColor: Colors.black,
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'League Spartan',
                              ),
                              keyboardType: TextInputType.text,
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      route['role'] != 'Doctor'
                          ? Container()
                          : TextFormField(
                              controller: _descriptionController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'Description',
                                labelStyle: TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                prefixIcon: Icon(Icons.account_circle_outlined),
                                prefixIconColor: Colors.black,
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'League Spartan',
                              ),
                              keyboardType: TextInputType.text,
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: 50,
                        child: myButton(
                          "Save",
                          () => route['role'] != 'Doctor'
                              ? addData1(route['role'])
                              : addData(),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
