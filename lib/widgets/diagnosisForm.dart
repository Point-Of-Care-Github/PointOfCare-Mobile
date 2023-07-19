import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../screens/symptomsScreen.dart';

class DiagnosisForm extends StatefulWidget {
  const DiagnosisForm({Key? key}) : super(key: key);

  @override
  State<DiagnosisForm> createState() => _DiagnosisFormState();
}

class _DiagnosisFormState extends State<DiagnosisForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'email': '',
    'contact': '',
    'name': '',
    'age': '',
  };
  bool _nameActive = false;
  bool _emailActive = false;
  bool _contactActive = false;
  bool _ageActive = false;
  bool _typeActive = false;
  String radioButtonItem = 'Male';
  int id = 1;
  String type = '';
  int id1 = 1;
  String _errorMessage = '';
  String _errorMessage1 = '';
  String _errorMessage2 = '';
  String _errorMessage3 = '';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints(minHeight: 320),
      width: deviceSize.width * 0.85,
      padding: EdgeInsets.all(deviceSize.width * 0.0427),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Heading
              Container(
                margin: EdgeInsets.only(
                  top: deviceSize.height * 0.135,
                  left: deviceSize.width * 0.0187,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Diagnosis',
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.1067,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // SubHeading
              Container(
                margin: EdgeInsets.only(
                  bottom: deviceSize.height * 0.025,
                  top: deviceSize.height * 0.005,
                  left: deviceSize.width * 0.0187,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter your personal details',
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.032,
                      color: Colors.black38,
                      fontFamily: 'League Spartan',
                    ),
                  ),
                ),
              ),

              // name field
              FocusScope(
                child: Focus(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: const Icon(Icons.account_circle_outlined),
                      prefixIconColor: Colors.black,
                    ),
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      validateName(val);
                    },
                    onSaved: (value) {
                      _authData['name'] = value!;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: deviceSize.height * 0.0075),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage2,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: deviceSize.width * 0.024,
                      fontFamily: 'League Spartan',
                    ),
                  ),
                ),
              ),

              // Email field
              FocusScope(
                child: Focus(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: const Icon(Icons.email_outlined),
                      prefixIconColor: Colors.black,
                    ),
                    onChanged: (val) {
                      validateEmail(val);
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: deviceSize.height * 0.0075),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: deviceSize.width * 0.024,
                      fontFamily: 'League Spartan',
                    ),
                  ),
                ),
              ),

              // Contact Field
              FocusScope(
                child: Focus(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contact',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: const Icon(Icons.contact_phone_outlined),
                      prefixIconColor: Colors.black,
                    ),
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      _authData['contact'] = value!;
                    },
                    onChanged: (val) {
                      validatePhone(val);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: deviceSize.height * 0.0075),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage1,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: deviceSize.width * 0.024,
                      fontFamily: 'League Spartan',
                    ),
                  ),
                ),
              ),

              // Age
              FocusScope(
                child: Focus(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: const Icon(Icons.group_outlined),
                      prefixIconColor: Colors.black,
                    ),
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _authData['age'] = value!;
                    },
                    onChanged: (val) {
                      validateAge(val);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: deviceSize.height * 0.0075),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage3,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: deviceSize.width * 0.024,
                      fontFamily: 'League Spartan',
                    ),
                  ),
                ),
              ),

              // Gender
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: deviceSize.height * 0.015,
                      left: deviceSize.width * 0.035,
                    ),
                    child: const Icon(
                      Icons.male_outlined,
                      color: Color(0xFF696969),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: deviceSize.width * 0.03,
                      top: deviceSize.height * 0.015,
                    ),
                    child: Text(
                      'Gender',
                      style: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF696969),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: deviceSize.height * 0.015),
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Male';
                              id = 1;
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
                              radioButtonItem = 'Female';
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
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(
                  right: deviceSize.width * 0.2,
                  top: deviceSize.height * 0.015,
                ),
                child: Text(
                  'Select the organ to be predicted:',
                  style: TextStyle(
                    fontFamily: 'League Spartan',
                    fontSize: deviceSize.width * 0.04,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF696969),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: deviceSize.height * 0.015),
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: id1,
                          onChanged: (val) {
                            setState(() {
                              type = 'Chest';
                              id1 = 1;
                              _typeActive = true;
                            });
                          },
                        ),
                        Text(
                          'Chest',
                          style: TextStyle(
                            fontFamily: 'League Spartan',
                            fontSize: deviceSize.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF696969),
                          ),
                        ),
                        Radio(
                          value: 2,
                          groupValue: id1,
                          onChanged: (val) {
                            setState(() {
                              type = 'Liver';
                              id1 = 2;
                              _typeActive = true;
                            });
                          },
                        ),
                        Text(
                          'Liver',
                          style: TextStyle(
                            fontFamily: 'League Spartan',
                            fontSize: deviceSize.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF696969),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: deviceSize.height * 0.015),
                    child: Row(
                      children: [
                        Radio(
                          value: 3,
                          groupValue: id1,
                          onChanged: (val) {
                            setState(() {
                              type = 'Kidney';
                              id1 = 3;
                              _typeActive = true;
                            });
                          },
                        ),
                        Text(
                          'Kidney',
                          style: TextStyle(
                            fontFamily: 'League Spartan',
                            fontSize: deviceSize.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF696969),
                          ),
                        ),
                        Radio(
                          value: 4,
                          groupValue: id1,
                          onChanged: (val) {
                            setState(() {
                              type = 'Breast';
                              id1 = 4;
                              _typeActive = true;
                            });
                          },
                        ),
                        Text(
                          'Breast',
                          style: TextStyle(
                            fontFamily: 'League Spartan',
                            fontSize: deviceSize.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF696969),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: deviceSize.height * 0.03,
              ),

              // Next button
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_ageActive &&
                        _contactActive &&
                        _emailActive &&
                        _typeActive &&
                        _nameActive) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SymptomsScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
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
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      width: deviceSize.width * 0.85,
                      height: deviceSize.height * 0.065,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Next',
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
      setState(() {
        _emailActive = true;
      });
    }
  }

  void validateName(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage2 = "Invalid Name";
      });
    } else {
      setState(() {
        _errorMessage2 = "";
      });
      setState(() {
        _nameActive = true;
      });
    }
  }

  void validatePhone(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage1 = "Invalid Number";
      });
    } else if (val.length < 10) {
      setState(() {
        _errorMessage1 = "Number can not be less than 11 digits";
      });
    } else {
      setState(() {
        _errorMessage1 = "";
      });
      setState(() {
        _contactActive = true;
      });
    }
  }

  void validateAge(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage3 = "Invalid Age";
      });
    } else if (int.parse(val) <= 0) {
      setState(() {
        _errorMessage3 = "Age cannot be 0 or less";
      });
    } else {
      setState(() {
        _errorMessage3 = "";
      });
      setState(() {
        _ageActive = true;
      });
    }
  }
}
