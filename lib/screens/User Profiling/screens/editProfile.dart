// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test/widgets/editProfileForm.dart';

// import '../models/users.dart';

// class EditProfile extends StatelessWidget {
//   static const routeName = '/edit-profile-screen';
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     final productsData = Provider.of<Users>(context);
//     final products = productsData.users;
//     return Scaffold(
//       key: scaffoldKey,
//       body: Stack(
//         children: <Widget>[
//           //header

//           Align(
//             alignment: Alignment.topRight,
//             child: Container(
//               //margin: const EdgeInsets.only(top: 15, right: 15),
//               child: const Image(
//                 image: AssetImage('assets/images/profileEclipse.png'),
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 0.0, top: 70.0, right: 25.0),
//             child: const Align(
//                 alignment: Alignment.topRight,
//                 child: Image(image: AssetImage('assets/images/authLogo.png'))),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 73, left: 40),
//             child: SizedBox(
//               child: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_ios,
//                   size: 30,
//                 ),
//                 color: Color(0xFF8587DC),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: 40, top: 130),
//                 child: Text(
//                   'Edit Profile',
//                   style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             height: deviceSize.height,
//             width: deviceSize.width,
//             child: SafeArea(
//               child: Column(
//                 //mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.topCenter,
//                     child: Container(
//                       width: 90,
//                       height: 90,
//                       margin: const EdgeInsets.only(right: 15, top: 130),
//                       child: CircleAvatar(
//                         backgroundImage:
//                             NetworkImage(products[1].pic.toString()),
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     flex: deviceSize.width > 600 ? 2 : 1,
//                     child: EditProfileForm(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
