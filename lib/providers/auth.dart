import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/constants/const.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? userid;
  String? useremail;
  String? userName;
  String? Role;
  List<Auth> _users = [];

  Auth({
    required this.userid,
    required this.useremail,
    required this.userName,
    required this.Role,
  });

  Auth.toauth();

  List<Auth> get users {
    return [..._users];
  }

  String? get role {
    return Role;
  }

  String? get username {
    return userName;
  }

  String? get userId {
    return userid;
  }

  String? get userEmail {
    return useremail;
  }

  Future<void> login(String email, String password) async {
    final url = "$nodeApi/api/users/login";
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
      if (responseData['error'] != null) {
        throw HttpException(responseData['message']);
      }
      userid = responseData['user']['_id'];
      useremail = responseData['user']['email'];
      userName = responseData['user']['name'];
      Role = responseData['user']['role'];
      notifyListeners();
    } catch (e) {
      print("Error:" + e.toString());
      throw e;
    }
  }

  Future<void> signup(
      String name, String email, String password, String role) async {
    final url = "$nodeApi/api/users/signup";
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
      userid = responseData['user']['_id'];
      useremail = responseData['user']['email'];
      userName = responseData['user']['name'];
      Role = responseData['user']['role'];
      // _expiryDate = DateTime.now().add(
      //   Duration(seconds: int.parse(responseData['expiresIn'])),
      // );
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> fetchUsers() async {
    final url = "$nodeApi/api/users";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      var extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      extractedData = extractedData['users'] as List;
      print(extractedData);

      final List<Auth> loadedUsers = [];
      for (int i = 0; i < extractedData.length; i++) {
        var doc = extractedData[i];
        loadedUsers.add(Auth(
            userid: doc['id'],
            userName: doc['name'],
            useremail: doc['email'],
            Role: doc['role']));
      }
      _users = loadedUsers;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
    notifyListeners();
  }

  void logout() {
    userid = null;
    notifyListeners();
  }
}
