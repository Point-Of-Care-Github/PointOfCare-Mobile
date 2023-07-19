import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class GridItem with ChangeNotifier {
  final String id;
  final String title;
  final String icon;

  GridItem({
    required this.id,
    required this.title,
    required this.icon,
  });
}
