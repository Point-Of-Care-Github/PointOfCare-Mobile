// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';

class Appointment extends ChangeNotifier {
  final String doctorId;
  final String userId;
  final String gender;
  final String contact;
  final String reason;
  final String time;
  final String date;
  final String name;
  final String status;
  final String age;
  final String id;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.gender,
    required this.contact,
    required this.reason,
    required this.status,
    required this.date,
    required this.time,
    required this.age,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctorId': doctorId,
      'userId': userId,
      'gender': gender,
      'contact': contact,
      'reason': reason,
      'status': status,
      'date': date,
      'time': time,
      'age': age,
      'name': name,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] ?? '',
      doctorId: map['doctorId'] ?? '',
      userId: map['userId'] ?? '',
      gender: map['gender'] ?? '',
      contact: map['contact'] ?? '',
      reason: map['reason'] ?? '',
      status: map['status'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      age: map['age'] ?? '',
      name: map['name'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source));
}
