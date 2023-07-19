import 'package:flutter/material.dart';

import './user.dart';

class Users with ChangeNotifier {
  final List<User> _users = [
    // User(
    //   id: 'p1',
    //   name: 'Kulsoom Khurshid',
    //   email: 'kulsoomkhurshid26@gmail.com',
    //   contact: '0332-5316694',
    //   age: '22 years',
    //   gender: 'female',
    //   pic:
    //       'https://images.pexels.com/photos/1587009/pexels-photo-1587009.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    // ),
    // User(
    //   id: 'p2',
    //   name: 'Hashir Hamid',
    //   email: 'hashirhamid@gmail.com',
    //   contact: '0332-5674453',
    //   age: '22 years',
    //   gender: 'male',
    //   pic:
    //       'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    // ),
  ];
  List<User> get users {
    return [..._users];
  }

  User findById(String id) {
    return _users.firstWhere((user) => user.id == id);
  }

  void updateProduct(String id, User newProduct) {
    final prodIndex = _users.indexWhere((user) => user.id == id);
    if (prodIndex >= 0) {
      _users[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
