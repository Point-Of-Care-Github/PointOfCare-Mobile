// ignore_for_file: file_names

import 'dart:convert';

class Doctors {
  final String userId;
  final String gender;
  final String contact;
  final String experience;
  final String specialization;
  final String description;
  final String time;
  final String fees;
  final String image;
  final String name;
  final String email;

  Doctors(
      {required this.userId,
      required this.gender,
      required this.contact,
      required this.experience,
      required this.specialization,
      required this.description,
      required this.time,
      required this.fees,
      required this.image,
      required this.email,
      required this.name});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'gender': gender,
      'contact': contact,
      'experience': experience,
      'specialization': specialization,
      'description': description,
      'time': time,
      'fees': fees,
      'image': image,
    };
  }

  factory Doctors.fromMap(Map<String, dynamic> map) {
    return Doctors(
        userId: map['userId'] ?? '',
        gender: map['gender'] ?? '',
        contact: map['contact'] ?? '',
        experience: map['experience'] ?? '',
        specialization: map['specialization'] ?? '',
        description: map['description'] ?? '',
        time: map['time'] ?? '',
        fees: map['fees'] ?? '',
        image: map['image'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '');
  }
  String toJson() => json.encode(toMap());

  factory Doctors.fromJson(String source) =>
      Doctors.fromMap(json.decode(source));
}
