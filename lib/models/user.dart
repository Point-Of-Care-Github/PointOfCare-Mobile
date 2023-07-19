import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String? id;
  String? name;
  String? email;
  String? contact;
  String? age;
  String? password;
  String? gender;
  String? pic;

  User.fromuser();
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.age,
    required this.password,
    required this.gender,
    required this.pic,
  });
}
