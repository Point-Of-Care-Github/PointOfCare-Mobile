import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/auth.dart';
import 'package:test/screens/Result%20and%20Reporting/screens/reportScreen.dart';
import 'package:test/utils/customProgess.dart';

import '../../../utils/reports.dart';

class ReportList extends StatefulWidget {
  static const routeName = 'report-list';

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  bool flag = true;

  @override
  void initState() {
    Provider.of<Reports>(context, listen: false).fetchReports().then((_) {
      setState(() {
        flag = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).userId;
    final report = Provider.of<Reports>(context, listen: false);
    var reportList =
        report.reports.where((element) => element['id'] == user).toList();
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          //header
          const Image(
            image: AssetImage('assets/images/topWaves1.png'),
          ),

          Container(
            margin: EdgeInsets.only(left: 100, top: 73),
            width: deviceSize.width * 0.55,
            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  labelStyle: TextStyle(
                    fontFamily: 'League Spartan',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                  prefixIcon: Icon(Icons.search_outlined),
                  prefixIconColor: Colors.black,
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'League Spartan',
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50, top: 160),
            child: Text(
              'My Reports',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            // ignore: sized_box_for_whitespace
            child: Container(
              height: deviceSize.height * 0.9,
              width: deviceSize.width,
              margin: EdgeInsets.only(top: 200),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: flag
                          ? CircularProgressIndicator()
                          : reportList.length == 0
                              ? Text("No reports to show!")
                              : ListView.builder(
                                  itemCount: reportList.length,
                                  itemBuilder: (context, position) {
                                    var time = reportList[position]['time']
                                        .split(' ')[0];
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReportScreen(
                                                      reportList[position]
                                                          ['results'],
                                                      reportList[position]
                                                          ['image']))),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: deviceSize.width * 0.8,
                                          child: Card(
                                              elevation: 18,
                                              child: ListTile(
                                                title: Text(
                                                  reportList[position]['name'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xFF200e32),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  time,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                leading: Container(
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                            begin: Alignment
                                                                .topRight,
                                                            end: Alignment
                                                                .bottomLeft,
                                                            colors: [
                                                          Color(0xFFB9A0E6),
                                                          Color(0xFF8587DC),
                                                        ]),
                                                  ),
                                                  child: Container(
                                                    width: 55,
                                                    height: 55,
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                    child: Center(
                                                      child: Text(
                                                        "Report",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 73, left: 40),
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
          ),
        ],
      ),
    );
  }
}
