import 'dart:convert';

class Patient {
  String userId;
  String gender;
  String contact;
  String age;
  String image;

  Patient({
    required this.userId,
    required this.gender,
    required this.contact,
    required this.age,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'gender': gender,
      'contact': contact,
      'age': age,
      'image': image,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      userId: map['userId'] ?? '',
      gender: map['gender'] ?? '',
      contact: map['contact'] ?? '',
      age: map['age'] ?? '',
      image: map['image'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));
}
