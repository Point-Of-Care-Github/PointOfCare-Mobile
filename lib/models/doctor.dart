import 'dart:convert';

class Doctor {
  final String userId;
  final String gender;
  final String contact;
  final String experience;
  final String specialization;
  final String description;
  final String time;
  final String fees;
  final String image;
  final String id;

  Doctor({
    required this.id,
    required this.userId,
    required this.gender,
    required this.contact,
    required this.experience,
    required this.specialization,
    required this.description,
    required this.time,
    required this.fees,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      gender: map['gender'] ?? '',
      contact: map['contact'] ?? '',
      experience: map['experience'] ?? '',
      specialization: map['specialization'] ?? '',
      description: map['description'] ?? '',
      time: map['time'] ?? '',
      fees: map['fees'] ?? '',
      image: map['image'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) => Doctor.fromMap(json.decode(source));
}
