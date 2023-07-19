import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../screens/xrayUploadScreen.dart';

class XrayForm extends StatefulWidget {
  const XrayForm({super.key});

  @override
  State<XrayForm> createState() => _XrayFormState();
}

class _XrayFormState extends State<XrayForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _passwordController = TextEditingController();
  Map<String, String> _authData = {
    'email': '',
    'contact': '',
    'name': '',
    'age': '',
  };
  bool _nameActive = false;
  bool _emailActive = false;
  bool _contactActive = false;
  bool _ageActive = false;
  String radioButtonItem = 'Male';
  int id = 1;
  String _errorMessage = '';
  String _errorMessage1 = '';
  String _errorMessage2 = '';
  String _errorMessage3 = '';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(minHeight: 320),
      width: deviceSize.width * 0.85,
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Heading
              Container(
                margin: const EdgeInsets.only(top: 70, left: 7),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'X-ray Diagnosis',
                    style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              //SubHeading
              Container(
                margin: const EdgeInsets.only(bottom: 40, top: 10, left: 7),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter your personal details',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black38,
                      fontFamily: 'League Spartan',
                    ),
                  ),
                ),
              ),

              //name field
              FocusScope(
                child: Focus(
                  child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
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
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        validateName(val);
                      },
                      onSaved: (value) {
                        _authData['name'] = value!;
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage2,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: 'League Spartan'),
                  ),
                ),
              ),

              //Email field
              FocusScope(
                child: Focus(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                      prefixIconColor: Colors.black,
                    ),
                    onChanged: (val) {
                      validateEmail(val);
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: 'League Spartan'),
                  ),
                ),
              ),

              //contact Field
              FocusScope(
                child: Focus(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Contact',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: Icon(Icons.contact_phone_outlined),
                      prefixIconColor: Colors.black,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
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
                padding: const EdgeInsets.only(top: 3.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage1,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: 'League Spartan'),
                  ),
                ),
              ),

              //Age
              FocusScope(
                child: Focus(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: Icon(Icons.group_outlined),
                      prefixIconColor: Colors.black,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
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
                padding: const EdgeInsets.only(top: 3.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage3,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: 'League Spartan'),
                  ),
                ),
              ),
              Row(children: [
                Container(
                    margin: EdgeInsets.only(top: 10, left: 13),
                    child: Icon(
                      Icons.male_outlined,
                      color: Color(0xFF696969),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    'Gender',
                    style: TextStyle(
                      fontFamily: 'League Spartan',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF696969),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
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
                        style: new TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF696969),
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
                        style: new TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF696969),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),

              const SizedBox(
                height: 70,
              ),

              //next button
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_ageActive &&
                        _contactActive &&
                        _emailActive &&
                        _nameActive) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => XrayUploadScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFB9A0E6),
                              Color(0xFF8587DC),
                            ]),
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      width: deviceSize.width * 0.85,
                      height: 52,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Next',
                          style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
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
