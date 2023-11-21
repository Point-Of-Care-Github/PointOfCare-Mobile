import 'package:flutter/material.dart';

import '../models/patient.dart';

class PatientProvider extends ChangeNotifier {
  Patient _patient = Patient(
    userId: '',
    gender: '',
    contact: '',
    age: '',
    image: '',
  );

  Patient get patient => _patient;

  void setPatient(String patient) {
    _patient = Patient.fromJson(patient);
    notifyListeners();
  }

  void setPatientFromModel(Patient patient) {
    _patient = patient;
    notifyListeners();
  }
}
