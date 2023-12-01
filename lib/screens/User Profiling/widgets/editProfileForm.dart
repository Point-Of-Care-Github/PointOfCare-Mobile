// ignore_for_file: file_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test/constants/const.dart';
import 'package:test/providers/auth.dart';
import 'package:test/providers/auth_services.dart';
import 'package:test/providers/doctor.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/providers/patient.dart';
import 'package:test/providers/patient_profile.dart';
import 'package:test/providers/radiologist.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/screens/Main/screens/tabScreen.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  int id = 1;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _imgXFile;

  final TextEditingController _imageController = TextEditingController();

  String? contact;
  String? age;
  String? gender;
  String? exp;
  String? specialization;
  String? description;
  String? fees;
  String? time;
  String? name;
  String? email;
  Future<void> _getImage(ImageSource source, String name) async {
    try {
      final imgXFile = await _imagePicker.pickImage(source: source);

      if (imgXFile != null) {
        setState(() {
          _imgXFile = imgXFile;
          _imageController.text = imgXFile.path;
        });

        // Replace the following line with your Firebase storage upload logic
        uploadImageToFirebase(imgXFile, name);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> uploadImageToFirebase(XFile imgXFile, String name) async {
    final firebaseStorage = FirebaseStorage.instance;
    var file = File(imgXFile.path);
    var storageRef = firebaseStorage.ref().child(name);

    var uploadTask = storageRef.putFile(file);
    var snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == TaskState.success) {
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _imageController.text = downloadUrl;
      });
      print('Download URL: $downloadUrl');
    }
  }
  // Future<void> uploadImage(String name, ImageSource source) async {
  //   print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
  //   final firebaseStorage = FirebaseStorage.instance;
  //   final imgXFile = await imagePicker.pickImage(source: source);
  //   print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
  //   if (imgXFile != null) {
  //     var file = File(imgXFile.path);
  //     var storageRef = firebaseStorage.ref().child(name);

  //     var uploadTask = storageRef.putFile(file);
  //     var snapshot = await uploadTask.whenComplete(() {});

  //     if (snapshot.state == TaskState.success) {
  //       var downloadUrl = await snapshot.ref.getDownloadURL();
  //       setState(() {
  //         _imageController.text = downloadUrl;
  //       });
  //     }
  //   }
  // }

  final AuthService authService = AuthService();

  void updateDoctor(String email) async {
    // ignore: use_build_context_synchronously
    authService.updateDoctor(
        context: context,
        email: email,
        gender: gender!,
        contact: contact!,
        experience: exp!,
        specialization: specialization!,
        description: description!,
        time: time!,
        fees: fees!,
        image: _imageController.text,
        name: name!);
  }

  void updatePatient(String email) async {
    // ignore: use_build_context_synchronously
    authService.updatePatient(
        context: context,
        email: email,
        gender: gender!,
        contact: contact!,
        age: age!,
        image: _imageController.text,
        name: name!);
  }

  void updateRadiologist(String email) async {
    // ignore: use_build_context_synchronously
    authService.updatePatient(
        context: context,
        email: email,
        gender: gender!,
        contact: contact!,
        age: age!,
        image: _imageController.text,
        name: name!);
  }

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
    final role = user.role;
    final deviceSize = MediaQuery.of(context).size;
    if (role == 'Doctor') {
      name = user.userName!;
      gender = type.gender;
      contact = type.contact;
      description = type.description;
      exp = type.experience;
      specialization = type.specialization;
      fees = type.fees;
      time = type.time;
      email = user.useremail;
      _imageController.text = type.image;
    }
    if (role == 'Patient' || role == 'Radiologist') {
      name = user.userName!;
      gender = type.gender;
      contact = type.contact;
      age = type.age;
      email = user.useremail;
      _imageController.text = type.image;
    }

    return Container(
      margin: EdgeInsets.only(
          top: deviceSize.height * 0.14, left: deviceSize.width * 0.07),
      child: Column(
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: deviceSize.width * 0.20,
              backgroundImage: _imgXFile == null
                  ? NetworkImage(_imageController.text) as ImageProvider
                  : FileImage(File(_imgXFile!.path)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _getImage(ImageSource.camera, name!);
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFB9A0E6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Camera',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  _getImage(ImageSource.gallery, name!);
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFB9A0E6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Gallery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: deviceSize.width * 0.85,
            child: TextFormField(
                decoration: decoration("Name", Icons.account_circle),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'League Spartan',
                ),
                keyboardType: TextInputType.emailAddress,
                initialValue: name,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: deviceSize.width * 0.85,
            child: TextFormField(
              decoration: decoration("Email", Icons.email_outlined),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'League Spartan',
              ),
              keyboardType: TextInputType.emailAddress,
              initialValue: email,
              readOnly: true,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (role == 'Patient' || role == 'Radiologist')
            Container(
              width: deviceSize.width * 0.85,
              child: TextFormField(
                  decoration: decoration("Age", Icons.group_outlined),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'League Spartan',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  initialValue: age,
                  onChanged: (value) {
                    setState(() {
                      // _ageController.text = value;
                      age = value;
                    });
                  }),
            ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: deviceSize.width * 0.85,
            child: TextFormField(
              decoration: decoration("Contact", Icons.phone_outlined),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'League Spartan',
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  // _contactController.text = value;
                  contact = value;
                });
              },
              initialValue: contact,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (role == 'Doctor')
            Container(
              width: deviceSize.width * 0.85,
              child: TextFormField(
                  decoration: decoration(
                      "Specialization", Icons.app_registration_rounded),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'League Spartan',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  initialValue: specialization,
                  onChanged: (value) {
                    setState(() {
                      //_specializationController.text = value;
                      specialization = value;
                    });
                  }),
            ),
          if (role == 'Doctor')
            SizedBox(
              height: 20,
            ),
          if (role == 'Doctor')
            Container(
              width: deviceSize.width * 0.85,
              child: TextFormField(
                  decoration: decoration("Experience", Icons.badge),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'League Spartan',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  initialValue: exp,
                  onChanged: (value) {
                    setState(() {
                      // _experienceController.text = value;
                      exp = value;
                    });
                  }),
            ),
          if (role == 'Doctor')
            SizedBox(
              height: 20,
            ),
          if (role == 'Doctor')
            Container(
              width: deviceSize.width * 0.85,
              child: TextFormField(
                  initialValue: description,
                  decoration:
                      decoration("Description", Icons.app_registration_rounded),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'League Spartan',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      //_descriptionController.text = value;
                      description = value;
                    });
                  }),
            ),
          if (role == 'Doctor')
            SizedBox(
              height: 20,
            ),
          if (role == 'Doctor')
            Container(
              width: deviceSize.width * 0.85,
              child: TextFormField(
                  initialValue: fees,
                  decoration: decoration("Fees", Icons.money),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'League Spartan',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      //_feesController.text = value;
                      fees = value;
                    });
                  }),
            ),
          if (role == 'Doctor')
            SizedBox(
              height: 20,
            ),
          if (role == 'Doctor')
            Container(
              width: deviceSize.width * 0.85,
              child: TextFormField(
                  initialValue: time,
                  decoration: decoration("Time", Icons.watch_later_outlined),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'League Spartan',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      // _timeController.text = value;
                      time = value;
                    });
                  }),
            ),
          if (role == 'Doctor')
            SizedBox(
              height: 20,
            ),
          Container(
            margin: EdgeInsets.only(left: deviceSize.width * 0.04),
            child: Row(
              children: [
                Icon(Icons.group_outlined, color: primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Gender",
                  style: TextStyle(
                    fontFamily: "League Spartan",
                    fontSize: deviceSize.width * 0.04,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    id = 1;
                    gender = 'Male';
                  });
                },
              ),
              Text(
                'Male',
                style: TextStyle(
                  fontFamily: 'League Spartan',
                  fontSize: deviceSize.width * 0.04,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF696969),
                ),
              ),
              Radio(
                value: 2,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    gender = 'Female';
                    id = 2;
                  });
                },
              ),
              Text(
                'Female',
                style: TextStyle(
                  fontFamily: 'League Spartan',
                  fontSize: deviceSize.width * 0.04,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF696969),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                if (role == 'Doctor') {
                  if (_imageController.text == '') {
                    if (id == 1) {
                      gender = 'Male';
                    } else {
                      gender = 'Female';
                    }
                    _imageController.text = type.image;
                    updateDoctor(email!);
                  }
                } else if (role == 'Patient') {
                  if (_imageController.text == '') {
                    if (id == 1) {
                      gender = 'Male';
                    } else {
                      gender = 'Female';
                    }
                    _imageController.text = type.image;
                    updatePatient(email!);
                    print(name);
                  }
                } else {
                  if (_imageController.text == '') {
                    if (id == 1) {
                      gender = 'Male';
                    } else {
                      gender = 'Female';
                    }
                    _imageController.text = type.image;
                    updatePatient(email!);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFB9A0E6),
                      Color(0xFF8587DC),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: deviceSize.width * 0.85,
                  height: deviceSize.height * 0.065,
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.048,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration decoration(name, icon) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: primaryColor)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400)),
      labelText: name,
      labelStyle: TextStyle(
        // fontFamily: 'League Spartan',
        fontSize: 16,
        color: Colors.grey.shade400,
        fontWeight: FontWeight.w600,
      ),
      floatingLabelStyle: TextStyle(color: primaryColor),
      prefixIconColor: primaryColor,
      prefixIcon: Icon(
        icon,
        // color: Colors.grey.shade400,
      ),
    );
  }
}
