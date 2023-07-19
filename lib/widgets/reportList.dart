import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/reports.dart';

class ReportList extends StatefulWidget {
  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    final report = Provider.of<Reports>(context);
    final reportList = report.reports;
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: reportList.length,
      itemBuilder: (context, position) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: deviceSize.width * 0.8,
            child: Card(
                elevation: 18,
                child: ListTile(
                  title: Text(
                    reportList[position].name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF200e32),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Result: ' + reportList[position].result,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  leading: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFFB9A0E6),
                            Color(0xFF8587DC),
                          ]),
                    ),
                    child: Container(
                      width: 55,
                      height: 55,
                      padding: EdgeInsets.only(top: 5),
                      child: Column(children: [
                        Text(
                          reportList[position].date.substring(0, 2),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          reportList[position].date.substring(3, 6),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
