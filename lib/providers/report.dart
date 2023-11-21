import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/constants/const.dart';
import 'package:http/http.dart' as http;
import 'package:test/utils/labels.dart';

class Results extends ChangeNotifier {
  List<Map<String, dynamic>> _results = [];

  Results();

  List<Map<String, dynamic>> get result {
    return _results;
  }

  Future<void> diagnose(image) async {
    final api = Uri.parse('$flaskApi/xray');

    if (image == null) return;
    String base64Image = base64Encode(image!.readAsBytesSync());
    await http.post(api, body: {
      'file': base64Image,
    }).then((res) {
      print(res.statusCode);
      print(res.body);
      final response = json.decode(res.body);
      _results = [];

      for (int i = 0; i < labels.length; i++) {
        _results.add({
          labels[i]: {
            'percentage': response['percentages'][i],
            'heatmap': response['heatmaps'][i]
          }
        });
      }
      print(_results.length);
      notifyListeners();
    });
  }
}
