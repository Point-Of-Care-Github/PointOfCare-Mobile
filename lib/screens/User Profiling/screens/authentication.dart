// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:email_otp/email_otp.dart';
import 'package:test/constants/const.dart';
import 'package:test/screens/User%20Profiling/screens/email-otp.dart';

import '../../../providers/auth.dart';
import '../../../widgets/MyButton.dart';

enum AuthMode { Signup, Login }

class Authentication extends StatefulWidget {
  static const routeName = '/auth';

  Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/images/eclipse.png'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0.0, top: 40.0, right: 25.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/images/authLogo.png',
                            height: 75,
                            width: 75,
                          )),
                    ),
                  ],
                ),
                AuthCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  EmailOTP myauth = EmailOTP();
  bool _isLoading = false;

  Future<void> sendOTP(String email) async {
    myauth.setConfig(
        appEmail: "Hashir@POC.com",
        appName: "Point-Of-Care",
        userEmail: email,
        otpLength: 6,
        otpType: OTPType.digitsOnly);
    if (await myauth.sendOTP() == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("OTP has been sent"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Oops, OTP send failed"),
      ));
    }
  }

  void login() {
    setState(() {
      _isLoading = true;
    });
    // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    if (_authMode == AuthMode.Login) {
      if (_emailActive && _passwordActive) {
        Provider.of<Auth>(context, listen: false)
            .login(_emailController.text, _passwordController.text);
      }
    }
    if (_authMode == AuthMode.Signup) {
      if (_nameActive &&
          _cPasswordActive &&
          _sPasswordActive &&
          _semailActive) {
        sendOTP(_emailController.text).then((_) {
          Navigator.of(context).pushNamed(EmailOtp.routeName, arguments: {
            "name": _nameController.text,
            "email": _emailController.text,
            "password": _passwordController.text,
            "role": selectedValue,
            "myauth": myauth
          });

          setState(() {
            _isLoading = false;
          });
        });
      }
    }
  }

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
    'confirmPass': ''
  };

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  bool _nameActive = false;
  bool _emailActive = false;
  bool _semailActive = false;
  bool _passwordActive = false;
  bool _sPasswordActive = false;
  bool _cPasswordActive = false;
  String _errorMessage = '';
  String _errorMessage1 = '';
  String _errorMessage2 = '';
  String _errorMessage3 = '';
  String selectedValue = "Select the type";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Login Heading

              if (_authMode == AuthMode.Login)
                Container(
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              //signup Heading
              if (_authMode == AuthMode.Signup)
                Container(
                  margin: const EdgeInsets.only(left: 7, bottom: 20),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Create Account',
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              //Login Tagline
              if (_authMode == AuthMode.Login)
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Please Sign in to continue',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38,
                    ),
                  ),
                ),

              SizedBox(
                height: 40,
              ),

              //Signup name field
              if (_authMode == AuthMode.Signup)
                TextFormField(
                    controller: _nameController,
                    decoration: decoration("Name", Icons.account_circle),
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
              if (_authMode == AuthMode.Signup)
                Padding(
                  padding: const EdgeInsets.only(top: 3.0, bottom: 5),
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
              TextFormField(
                controller: _emailController,
                decoration: decoration("Email", Icons.email),
                onChanged: (val) {
                  validateEmail(val);
                },
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'League Spartan',
                ),
                onSaved: (value) {
                  _authData['email'] = value!;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, bottom: 5),
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

              //Password Field
              TextFormField(
                decoration: decoration("Password", Icons.lock),
                obscureText: true,
                controller: _passwordController,
                onChanged: (val) {
                  validatePass(val);
                },
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'League Spartan',
                ),
                onSaved: (value) {
                  _authData['password'] = value!;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, bottom: 5),
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

              //Signup confirm password
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  decoration: decoration("Confirm Password", Icons.lock),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'League Spartan',
                  ),
                  obscureText: true,
                  onSaved: (value) {
                    _authData['confirmPass'] = value!;
                  },
                  onChanged: (val) {
                    validateCPass(val);
                  },
                ),
              if (_authMode == AuthMode.Signup)
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
              // FittedBox(
              //   fit: BoxFit.cover,
              //   child: Row(children: <Widget>[
              //     const Text(
              //       'Select the user type:',
              //       style: TextStyle(
              //           fontFamily: 'League Spartan',
              //           fontSize: 15,
              //           color: Color(0xFF949494),
              //           fontWeight: FontWeight.w500),
              //     ),
              //     SizedBox(
              //       width: 29,
              //     ),
              //     DropdownButton(
              //       value: selectedValue,
              //       style: const TextStyle(
              //           color: Color(0xFF8587DC),
              //           fontSize: 16,
              //           fontFamily: 'League Spartan'),
              //       items: dropdownItems,
              //       onChanged: (String? newValue) {
              //         setState(() {
              //           selectedValue = newValue!;
              //         });
              //       },
              //     ),
              //   ]),
              // ),

              if (_authMode == AuthMode.Login)
                const SizedBox(
                  height: 40,
                ),
              if (_authMode == AuthMode.Signup)
                const SizedBox(
                  height: 20,
                ),

              //Login and signup button
              _isLoading
                  ? CircularProgressIndicator()
                  : Align(
                      alignment: Alignment.bottomRight,
                      child: myButton(
                        _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                        login,
                      ),
                    ),
              SizedBox(
                height: 50,
              ),
              //Login and Signup Login option
              // Text(
              //   _authMode == AuthMode.Login
              //       ? 'Or Login with'
              //       : 'Or Signup with',
              //   style: const TextStyle(
              //       fontSize: 19,
              //       fontFamily: 'Poppins',
              //       fontWeight: FontWeight.w700),
              // ),
              // Container(
              //   height: 20,
              // ),

              //Google facebook button
              // FittedBox(
              //   child: Row(children: <Widget>[
              //     SizedBox(
              //       width: 150,
              //       height: 52,
              //       child: TextButton(
              //         onPressed: () {},
              //         style: TextButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10), // <-- Radius
              //           ),
              //           side: const BorderSide(
              //             width: 3.0,
              //             color: Color(0xFF4267B2),
              //           ),
              //         ),
              //         child: Container(
              //           margin: const EdgeInsets.only(left: 9),
              //           // ignore: prefer_const_literals_to_create_immutables
              //           child: Row(children: <Widget>[
              //             const Icon(
              //               // <-- Icon
              //               Icons.facebook,
              //               size: 28.0,
              //               color: Color(0xFF4267B2),
              //             ),
              //             Container(
              //               margin: const EdgeInsets.only(left: 3),
              //               child: const Text(
              //                 'Facebook',
              //                 style: TextStyle(
              //                     fontSize: 18,
              //                     color: Color(0xFF4267B2),
              //                     fontFamily: 'Poppins',
              //                     fontWeight: FontWeight.w600),
              //               ),
              //             ),
              //           ]),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       width: 12,
              //     ),
              //     SizedBox(
              //       width: 150,
              //       height: 52,
              //       child: TextButton(
              //         onPressed: () {},
              //         style: TextButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10), // <-- Radius
              //           ),
              //           side: const BorderSide(
              //             width: 3.0,
              //             color: Color(0xFF5C8DF0),
              //           ),
              //         ),
              //         child: Container(
              //           margin: const EdgeInsets.only(left: 16),
              //           // ignore: prefer_const_literals_to_create_immutables
              //           child: Row(children: <Widget>[
              //             const Image(
              //               image: AssetImage('assets/images/google.png'),
              //               width: 24,
              //               height: 24,
              //             ),
              //             Container(
              //               margin: const EdgeInsets.only(left: 5),
              //               child: const Text(
              //                 'Google',
              //                 style: TextStyle(
              //                     fontSize: 18,
              //                     color: Color(0xFF4267B2),
              //                     fontFamily: 'Poppins',
              //                     fontWeight: FontWeight.w600),
              //               ),
              //             ),
              //           ]),
              //         ),
              //       ),
              //     ),
              //   ]),
              // ),

              //switch between signup and sign in
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5),
                child: Row(children: <Widget>[
                  Text(
                    _authMode == AuthMode.Login
                        ? "Don't have an account?"
                        : 'Already have an account?',
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'League Spartan',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF858383)),
                  ),
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      '${_authMode == AuthMode.Login ? 'Sign up' : 'Sign in'} ',
                      style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8587DC)),
                    ),
                  ),
                ]),
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
      if (_authMode == AuthMode.Login) {
        setState(() {
          _emailActive = true;
        });
      } else {
        setState(() {
          _semailActive = true;
        });
      }
    }
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

  void validatePass(String val) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    var passNonNullValue = val;
    if (passNonNullValue.isEmpty) {
      setState(() {
        _errorMessage1 = "Password is required";
      });
    } else if (passNonNullValue.length < 6) {
      setState(() {
        _errorMessage1 = "Password Must be more than 5 characters";
      });
    } else if (!regex.hasMatch(passNonNullValue)) {
      setState(() {
        _errorMessage1 =
            "Password should contain upper,lower,digit and Special character";
      });
    } else {
      setState(() {
        _errorMessage1 = "";
      });
      if (_authMode == AuthMode.Login) {
        setState(() {
          _passwordActive = true;
        });
      } else {
        setState(() {
          _sPasswordActive = true;
        });
      }
    }
  }

  void validateCPass(String val) {
    var passNonNullValue = val;
    if (passNonNullValue.isEmpty) {
      setState(() {
        _errorMessage3 = "Confirm your Password";
      });
    }
    // } else if (passNonNullValue != _authData['password']) {
    //   setState(() {
    //     _errorMessage3 = "Passwords don't match";
    //   });
    // }
    else {
      setState(() {
        _errorMessage3 = "";
      });
      setState(() {
        _cPasswordActive = true;
      });
    }
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("Select the type"), value: "Select the type"),
      DropdownMenuItem(child: Text("Doctor"), value: "Doctor"),
      DropdownMenuItem(child: Text("Radiologist"), value: "Radiologist"),
      DropdownMenuItem(child: Text("Patient"), value: "Patient"),
    ];
    return menuItems;
  }
}