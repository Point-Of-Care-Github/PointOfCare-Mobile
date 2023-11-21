// import 'package:flutter/material.dart';
// import 'package:test/constants/const.dart';

// class CustomField extends StatelessWidget {
//   const CustomField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(width: 1, color: primaryColor)),
//                       labelText: label,
//                       prefixIcon: Icon(Icons.lock_outline),
//                     ),
//                     obscureText: obsecureFlag,
//                     controller: _passwordController,
//                     onChanged: (val) {
//                       validatePass(val);
//                     },
//                     onSaved: (value) {
//                       _authData['password'] = value!;
//                     },
//                   );
//   }
// }