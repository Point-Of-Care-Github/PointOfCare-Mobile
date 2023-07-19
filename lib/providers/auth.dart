import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _userEmail;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  String? get userEmail {
    return _userEmail;
  }

  Future<void> login(String email, String password) async {
    const url = "http://192.168.56.1:5000/api/users/login";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      _token = responseData['token'];
      _userId = responseData['userId'];
      _userEmail = responseData['email'];
      print(_token);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(
      String name, String email, String password, String role) async {
    const url = "http://192.168.56.1:5000/api/users/signup";
    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
            {"name": name, "email": email, "password": password, "role": role},
          ));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['token'];
      _userId = responseData['userId'];
      _userEmail = responseData['email'];
      // _expiryDate = DateTime.now().add(
      //   Duration(seconds: int.parse(responseData['expiresIn'])),
      // );
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void logout() {
    _token = null;
    _userId = null;
    notifyListeners();
  }
}
