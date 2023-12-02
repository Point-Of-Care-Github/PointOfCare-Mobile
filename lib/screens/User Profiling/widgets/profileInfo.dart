import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final title;
  final subtitle;
  ProfileInfo(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 16),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
