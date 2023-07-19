import 'package:flutter/material.dart';

import './report.dart';

class Reports with ChangeNotifier {
  final List<Report> _reports = [
    Report(
      id: 'r1',
      name: 'Kulsoom Khurshid',
      result: 'Hernia',
      date: '28-Nov-2020',
    ),
    Report(
      id: 'r2',
      name: 'Hashir Hamid',
      result: 'Fibrosis',
      date: '28-Dec-2021',
    ),
    Report(
      id: 'r3',
      name: 'Ali Haider',
      result: 'Clear',
      date: '03-Jan-2022',
    ),
    Report(
      id: 'r4',
      name: 'Wasif Farid',
      result: 'Pneumonia',
      date: '18-Feb-2023',
    ),
  ];
  List<Report> get reports {
    return [..._reports];
  }

  Report findById(String id) {
    return _reports.firstWhere((report) => report.id == id);
  }
}
