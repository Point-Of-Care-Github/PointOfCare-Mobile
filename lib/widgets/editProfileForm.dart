// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test/screens/editProfile.dart';
// import 'package:test/screens/profile.dart';
// import '../models/user.dart';
// import '../models/users.dart';

// class EditProfileForm extends StatefulWidget {
//   @override
//   State<EditProfileForm> createState() => _EditProfileFormState();
// }

// class _EditProfileFormState extends State<EditProfileForm> {
//   final _form = GlobalKey<FormState>();

//   // var _editedProduct = User(
//   //   id: 'p2',
//   //   name: 'Hashir Hamid',
//   //   email: 'hashirhamid@gmail.com',
//   //   contact: '0332-5674453',
//   //   age: '22 years',
//   //   gender: 'male',
//   //   pic:
//   //       'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//   // );
//   // Map<String, String> _editData = {
//   //   'id': 'p2',
//   //   'name': 'Hashir Hamid',
//   //   'username': 'Hashir2_',
//   //   'email': 'hashirhamid@gmail.com',
//   //   'contact': '0332-5674453',
//   //   'age': '22 years',
//   //   'gender': 'male',
//   //   'address': 'House #11, street #20',
//   //   'pic':
//   //       'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//   // };

//   void _saveForm() {
//     //   _form.currentState!.save();
//     //   Provider.of<Users>(context, listen: false)
//     //       .updateProduct(_editedProduct.id, _editedProduct);
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => Profile()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productsData = Provider.of<Users>(context);
//     final products = productsData.users;
//     final deviceSize = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.only(left: 40),
//         child: Column(
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(top: 15, left: 25),
//               child: Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.account_circle_outlined,
//                     color: Color(0xFF8587dc),
//                     size: 30,
//                   ),
//                   Container(
//                     width: deviceSize.width * 0.5,
//                     margin: EdgeInsets.only(left: 20),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Name',
//                         //contentPadding: const EdgeInsets.only(bottom: 3),
//                         labelStyle: TextStyle(
//                           fontFamily: 'League Spartan',
//                           fontSize: 19,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'League Spartan',
//                       ),
//                       onSaved: (value) {
//                         setState(() {
//                           _editedProduct.name = value!;
//                         });
//                       },
//                       initialValue: products[1].name,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 15, left: 25),
//               child: Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.account_circle_outlined,
//                     color: Color(0xFF8587dc),
//                     size: 30,
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10, left: 25),
//               child: Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.email_outlined,
//                     color: Color(0xFF8587dc),
//                     size: 30,
//                   ),
//                   Container(
//                     width: deviceSize.width * 0.5,
//                     margin: EdgeInsets.only(left: 20),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Email',
//                         //contentPadding: const EdgeInsets.only(bottom: 3),
//                         labelStyle: TextStyle(
//                           fontFamily: 'League Spartan',
//                           fontSize: 19,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'League Spartan',
//                       ),
//                       onSaved: (value) {
//                         setState(() {
//                           _editedProduct.email = value!;
//                         });
//                       },
//                       initialValue: products[1].email,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10, left: 25),
//               child: Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.phone_enabled,
//                     color: Color(0xFF8587dc),
//                     size: 30,
//                   ),
//                   Container(
//                     width: deviceSize.width * 0.5,
//                     margin: EdgeInsets.only(left: 20),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Contact',
//                         //contentPadding: const EdgeInsets.only(bottom: 3),
//                         labelStyle: TextStyle(
//                           fontFamily: 'League Spartan',
//                           fontSize: 19,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'League Spartan',
//                       ),
//                       onSaved: (value) {
//                         setState(() {
//                           _editedProduct.contact = value!;
//                         });
//                       },
//                       initialValue: products[1].contact,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10, left: 25),
//               child: Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.group,
//                     color: Color(0xFF8587dc),
//                     size: 30,
//                   ),
//                   Container(
//                     width: deviceSize.width * 0.5,
//                     margin: EdgeInsets.only(left: 20),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Age',
//                         //contentPadding: const EdgeInsets.only(bottom: 3),
//                         labelStyle: TextStyle(
//                           fontFamily: 'League Spartan',
//                           fontSize: 19,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'League Spartan',
//                       ),
//                       initialValue: products[1].age,
//                       onSaved: (value) {
//                         setState(() {
//                           _editedProduct.age = value!;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10, left: 25),
//               child: Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.male_outlined,
//                     color: Color(0xFF8587dc),
//                     size: 30,
//                   ),
//                   Container(
//                     width: deviceSize.width * 0.5,
//                     margin: EdgeInsets.only(left: 20),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Gender',
//                         labelStyle: TextStyle(
//                           fontFamily: 'League Spartan',
//                           fontSize: 19,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'League Spartan',
//                       ),
//                       initialValue: products[1].gender,
//                       onSaved: (value) {
//                         setState(() {
//                           _editedProduct.gender = value!;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10, left: 25),
//               child: Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.location_on,
//                     color: Color(0xFF8587dc),
//                     size: 30,
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               margin: EdgeInsets.only(top: 20, right: 20, bottom: 20),
//               child: ElevatedButton(
//                 onPressed: _saveForm,
//                 style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.zero,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50))),
//                 child: Ink(
//                   decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                           begin: Alignment.topRight,
//                           end: Alignment.bottomLeft,
//                           colors: [
//                             Color(0xFFB9A0E6),
//                             Color(0xFF8587DC),
//                           ]),
//                       borderRadius: BorderRadius.circular(50)),
//                   child: Container(
//                     width: deviceSize.width * 0.7,
//                     height: 52,
//                     alignment: Alignment.center,
//                     child: Center(
//                       child: Text(
//                         'Submit',
//                         style: const TextStyle(
//                             fontSize: 24,
//                             fontFamily: 'Poppins',
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
