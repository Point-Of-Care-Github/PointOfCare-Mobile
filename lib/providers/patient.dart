import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test/constants/const.dart';
import 'package:test/models/http_exception.dart';

class Patient with ChangeNotifier {
  String? userId;
  String? age;
  String? contact;
  String? gender;
  String? image;

  List<Patient> _patients = [];

  Patient.frompat();

  Patient(
      {required this.userId,
      required this.age,
      required this.contact,
      required this.gender,
      required this.image});

  Patient getPatient(String id) {
    return _patients.firstWhere((element) => element.userId == id);
  }

  Future<void> fetchPatients() async {
    final url = "$nodeApi/api/users/patients";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      var extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      extractedData = extractedData['patients'] as List;
      print(extractedData);

      final List<Patient> loadedPatients = [];
      for (int i = 0; i < extractedData.length; i++) {
        var doc = extractedData[i];
        loadedPatients.add(Patient(
          age: doc['age'].toString(),
          contact: doc['contact'],
          gender: doc['gender'],
          image: doc['image'],
          userId: doc['userId'],
        ));
      }
      _patients = loadedPatients;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
    notifyListeners();
  }

  Future<void> addPatient(Patient patient) async {
    final url = "$nodeApi/api/users/addPatient";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            "userId": patient.userId,
            "age": patient.age,
            "contact": patient.contact,
            "gender": patient.gender,
            "image": patient.image,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['message']);
      }
      notifyListeners();
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}