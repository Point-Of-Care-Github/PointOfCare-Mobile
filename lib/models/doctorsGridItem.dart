import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DoctorsGridItem with ChangeNotifier {
  final String id;
  final String name;
  final String speciality;
  final String rating;
  final String icon;
  final String pic;

  DoctorsGridItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.pic,
    required this.speciality,
    required this.rating,
  });
}
