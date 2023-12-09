import 'package:flutter/material.dart';

Widget backButton(context) {
  return Container(
    margin: EdgeInsets.only(
      top: 70,
      left: 30,
    ),
    child: SizedBox(
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 30,
        ),
        color: Color(0xFF8587DC),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
