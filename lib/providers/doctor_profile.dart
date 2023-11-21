import 'package:flutter/material.dart';
import 'package:test/models/allDoctors.dart';
import '../models/doctor.dart';

class DoctorProvider extends ChangeNotifier {
  Doctor _doctor = Doctor(
      userId: '',
      gender: '',
      contact: '',
      experience: '',
      specialization: '',
      description: '',
      time: '',
      fees: '',
      image: '',
      id: '');

  List<Doctors> _doctorsList = [];
  List<Doctors> _doctorList = [];

  Doctor get doctor => _doctor;

  List<Doctors> get doctorsList => _doctorsList;
  List<Doctors> get doctorList => _doctorList;

  void setDoctor(String doctor) {
    _doctor = Doctor.fromJson(doctor);
    notifyListeners();
  }

  void setDoctorFromModel(Doctor doctor) {
    _doctor = doctor;
    notifyListeners();
  }

  void setDoctorsList(List<Doctors> doctorsList) {
    _doctorsList = doctorsList;
    notifyListeners();
  }

  void setDoctorList(List<Doctors> doctorList) {
    _doctorList = doctorList;
    notifyListeners();
  }
}
