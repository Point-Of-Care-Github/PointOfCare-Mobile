import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/diseaseLabels.dart';

class ResultLabels extends StatefulWidget {
  @override
  State<ResultLabels> createState() => _ResultLabelsState();
}

class _ResultLabelsState extends State<ResultLabels> {
  @override
  Widget build(BuildContext context) {
    final labels = Provider.of<DiseaseLabels>(context);
    final labelList = labels.labels;
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 14,
      itemBuilder: (context, position) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: deviceSize.width * 0.8,
            child: Card(
                elevation: 18,
                child: ListTile(
                  title: Text(
                    labelList[position].name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF200e32),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    labelList[position].percentage,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  leading: Padding(
                      padding: EdgeInsets.only(top: 10, left: 8),
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Color(0xFF200e32),
                      )),
                  trailing: Container(
                    margin: EdgeInsets.only(top: 17),
                    child: Text(
                      labelList[position].likeness,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
