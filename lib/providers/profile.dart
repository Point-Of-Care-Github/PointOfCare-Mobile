import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Doctor with ChangeNotifier {
  String? userId;
  String? age;
  String? contact;
  String? gender;
  String? image;
  String? specialization;
  String? experience;
  String? description;

  Doctor.fromdoc();

  Doctor(
      {required this.userId,
      required this.age,
      required this.contact,
      required this.gender,
      required this.experience,
      required this.description,
      required this.image,
      required this.specialization});

  Future<void> addDoctor(Doctor doctor) async {
    const url = "http://192.168.56.1:5000/api/users/addDoctor";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            "userId": doctor.userId,
            "age": doctor.age,
            "contact": doctor.contact,
            "gender": doctor.gender,
            "experience": doctor.experience,
            "image": doctor.image,
            "specialization": doctor.specialization,
            "description": doctor.description
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}

class Patient with ChangeNotifier {
  String? userId;
  String? age;
  String? contact;
  String? gender;
  String? image;

  Patient.frompat();

  Patient(
      {required this.userId,
      required this.age,
      required this.contact,
      required this.gender,
      required this.image});

  Future<void> addPatient(Patient patient) async {
    const url = "http://192.168.56.1:5000/api/users/addPatient";
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
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}

class Radiologist with ChangeNotifier {
  String? userId;
  String? age;
  String? contact;
  String? gender;
  String? image;

  Radiologist.fromrad();

  Radiologist(
      {required this.userId,
      required this.age,
      required this.contact,
      required this.gender,
      required this.image});

  Future<void> addRadiologist(Radiologist radiologist) async {
    const url = "http://192.168.56.1:5000/api/users/addRadiologist";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            "userId": radiologist.userId,
            "age": radiologist.age,
            "contact": radiologist.contact,
            "gender": radiologist.gender,
            "image": radiologist.image,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
