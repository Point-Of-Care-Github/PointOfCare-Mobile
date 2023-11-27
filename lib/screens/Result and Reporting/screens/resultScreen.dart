import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:test/constants/const.dart';
import 'package:test/providers/auth.dart';
import 'package:test/providers/doctor.dart';
import 'package:test/providers/patient.dart';
import 'package:test/providers/radiologist.dart';
import 'package:test/providers/report.dart';
import 'package:http/http.dart' as http;
import 'package:test/utils/labelColors.dart';
import 'package:test/utils/report_pdf.dart';
import '../../Main/screens/tabScreen.dart';

class ResultScreen extends StatefulWidget {
  static const routeName = '/result-screen';

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool flag = true;
  List percentages = [];
  List results = [];
  File? image;
  var type;
  var user;
  List flags = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  void initState() {
    results = Provider.of<Results>(context, listen: false).result;
    user = Provider.of<Auth>(context, listen: false);
    if (user.role == "Doctor") {
      type =
          Provider.of<Doctor>(context, listen: false).getDoctor(user.userId!);
    } else if (user.role == "Patient") {
      type =
          Provider.of<Patient>(context, listen: false).getPatient(user.userId!);
    } else {
      type = Provider.of<Radiologist>(context, listen: false)
          .getRadiologist(user.userId!);
    }

    print("Results:$results");

    print(results.length);

    results.sort((a, b) =>
        b.values.first['percentage'].compareTo(a.values.first['percentage']));

    results.reversed.toList();

    print("Results sorted: $results");
    super.initState();
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics
        .drawString("Report", PdfStandardFont(PdfFontFamily.helvetica, 30));

    page.graphics.drawString(
        "Name: " + user.username, PdfStandardFont(PdfFontFamily.helvetica, 10),
        bounds: Rect.fromLTRB(0, 50, 0, 0));

    page.graphics.drawString(
        "Age: " + type.age, PdfStandardFont(PdfFontFamily.helvetica, 10),
        bounds: Rect.fromLTRB(0, 70, 0, 0));

    page.graphics.drawString(
        "Gender: " + type.gender, PdfStandardFont(PdfFontFamily.helvetica, 10),
        bounds: Rect.fromLTRB(0, 90, 0, 0));

    page.graphics.drawString("Contact: " + type.contact,
        PdfStandardFont(PdfFontFamily.helvetica, 10),
        bounds: Rect.fromLTRB(0, 110, 0, 0));

    page.graphics.drawImage(
        PdfBitmap(
          await imageUrlToUint8List(type.image!),
        ),
        Rect.fromLTWH(300, 50, 150, 150));

    page.graphics.drawImage(
        PdfBitmap(
          await imageFileToUint8List(image!),
        ),
        Rect.fromLTWH(0, 300, 70, 70));
    page.graphics.drawString(
        "Original Image", PdfStandardFont(PdfFontFamily.helvetica, 7),
        bounds: Rect.fromLTWH(0, 380, 150, 50));
    double left = 100;
    double top = 300;
    for (int i = 0; i < 14; i++) {
      page.graphics.drawImage(
          PdfBitmap(
            await imageFileToUint8List(image!),
          ),
          Rect.fromLTWH(left, top, 70, 70));
      page.graphics.drawImage(
          PdfBitmap.fromBase64String(results[i].values.first['heatmap']),
          Rect.fromLTWH(left, top, 70, 70));
      final MapEntry<String, dynamic> entry = results[i].entries.first;
      final String key = entry.key;
      page.graphics.drawString(
          entry.key +
              " = " +
              (results[i][key]['percentage'] * 100).round().toString() +
              "%",
          PdfStandardFont(PdfFontFamily.helvetica, 7),
          bounds: Rect.fromLTWH(left, top + 80, 150, 50));

      left = left + 100;
      if (left == 500) {
        left = 0;
        top = top + 130;
      }
    }

    List<int> bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Report.pdf');
  }

  Future<List<int>> imageFileToUint8List(File file) async {
    final bytes = await file.readAsBytes();
    final uint8List = Uint8List.fromList(bytes);
    return uint8List;
  }

  Future<List<int>> imageUrlToUint8List(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Uint8List.fromList(response.bodyBytes);
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final route =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    image = File(route['image']);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 28,
                        color: primaryColor,
                      ),
                      onPressed: _createPDF,
                      color: Color(0xFF200e32),
                    ),
                    Text(
                      'Result',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.download,
                        size: 30,
                        color: primaryColor,
                      ),
                      onPressed: _createPDF,
                      color: Color(0xFF200e32),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                // ignore: sized_box_for_whitespace
                child: Container(
                  height: deviceSize.height * 0.88,
                  width: deviceSize.width,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 0, bottom: 10),
                          child: Stack(
                            children: [
                              Container(
                                // margin: EdgeInsets.only(top: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: Image.file(
                                    //to show image, you type like this.
                                    File(route['image']),
                                    fit: BoxFit.cover,
                                    // width: deviceSize.width * 0.7,
                                    // height: deviceSize.height * 0.3,
                                  ),
                                ),
                              ),
                              flags[0]
                                  ? Image.memory(base64Decode(
                                      results[0].values.first['heatmap']))
                                  : SizedBox(),
                              flags[1]
                                  ? Image.memory(base64Decode(
                                      results[1].values.first['heatmap']))
                                  : SizedBox(),
                              flags[2]
                                  ? Image.memory(base64Decode(
                                      results[2].values.first['heatmap']))
                                  : SizedBox(),
                              flags[3]
                                  ? Image.memory(base64Decode(
                                      results[3].values.first['heatmap']))
                                  : SizedBox(),
                              flags[4]
                                  ? Image.memory(base64Decode(
                                      results[4].values.first['heatmap']))
                                  : SizedBox(),
                              flags[5]
                                  ? Image.memory(base64Decode(
                                      results[5].values.first['heatmap']))
                                  : SizedBox(),
                              flags[6]
                                  ? Image.memory(base64Decode(
                                      results[6].values.first['heatmap']))
                                  : SizedBox(),
                              flags[7]
                                  ? Image.memory(base64Decode(
                                      results[7].values.first['heatmap']))
                                  : SizedBox(),
                              flags[8]
                                  ? Image.memory(base64Decode(
                                      results[8].values.first['heatmap']))
                                  : SizedBox(),
                              flags[9]
                                  ? Image.memory(base64Decode(
                                      results[9].values.first['heatmap']))
                                  : SizedBox(),
                              flags[10]
                                  ? Image.memory(base64Decode(
                                      results[10].values.first['heatmap']))
                                  : SizedBox(),
                              flags[11]
                                  ? Image.memory(base64Decode(
                                      results[11].values.first['heatmap']))
                                  : SizedBox(),
                              flags[12]
                                  ? Image.memory(base64Decode(
                                      results[12].values.first['heatmap']))
                                  : SizedBox(),
                              flags[13]
                                  ? Image.memory(base64Decode(
                                      results[13].values.first['heatmap']))
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: deviceSize.width > 600 ? 2 : 1,
                          child: ListView.builder(
                            itemCount: 14,
                            itemBuilder: (context, position) {
                              final MapEntry<String, dynamic> entry =
                                  results[position].entries.first;
                              final String key = entry.key;

                              return Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: deviceSize.width * 0.9,
                                  child: Card(
                                      elevation: 18,
                                      color: flags[position]
                                          ? labelColors[key]
                                          : Colors.white,
                                      child: ListTile(
                                        titleAlignment:
                                            ListTileTitleAlignment.top,
                                        title: Text(
                                          key,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: flags[position]
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Text(
                                          (results[position][key]
                                                              ['percentage'] *
                                                          100)
                                                      .round() >
                                                  70
                                              ? "Very Likely"
                                              : (results[position][key][
                                                                  'percentage'] *
                                                              100)
                                                          .round() >
                                                      50
                                                  ? "Likely"
                                                  : (results[position][key][
                                                                      'percentage'] *
                                                                  100)
                                                              .round() >
                                                          35
                                                      ? "Uncertain"
                                                      : "Unlikely",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: flags[position]
                                                ? Colors.grey.shade200
                                                : Colors.black45,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        leading: Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 8),
                                            child: IconButton(
                                              icon: flags[position]
                                                  ? Icon(
                                                      Icons.remove_red_eye,
                                                      color: Colors.white,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                    ),
                                              onPressed: () {
                                                setState(() {
                                                  flags[position] =
                                                      !flags[position];
                                                });
                                              },
                                              color: Color(0xFF200e32),
                                            )),
                                        trailing: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                (results[position][key]
                                                                ['percentage'] *
                                                            100)
                                                        .round()
                                                        .toString() +
                                                    "%",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: flags[position]
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
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
              // Row(
              //   children: <Widget>[
              //     Container(
              //       alignment: Alignment.bottomCenter,
              //       child: SizedBox(
              //         width: deviceSize.width * 0.5,
              //         height: deviceSize.height * 0.1,
              //         child: ElevatedButton.icon(
              //           label: Text('Home'),
              //           style: ElevatedButton.styleFrom(
              //               primary: Color(0xFF8587DC),
              //               textStyle: TextStyle(
              //                 fontFamily: 'Poppins',
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold,
              //               )),
              //           onPressed: () {
              //             Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (context) => TabsScreen()));
              //           },
              //           icon: Icon(
              //             Icons.home,
              //             size: 26,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       alignment: Alignment.bottomCenter,
              //       child: SizedBox(
              //         width: deviceSize.width * 0.5,
              //         height: deviceSize.height * 0.1,
              //         child: ElevatedButton.icon(
              //           label: Text('Book appointment'),
              //           style: ElevatedButton.styleFrom(
              //               primary: Color(0xFFACADFF),
              //               textStyle: TextStyle(
              //                 fontFamily: 'Poppins',
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold,
              //               )),
              //           onPressed: () {
              //             Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (context) => DoctorRecommendationScreen()));
              //           },
              //           icon: Icon(
              //             Icons.location_on,
              //             size: 26,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Container(
              //   margin: EdgeInsets.only(top: 65, left: 30),
              //   child: SizedBox(
              //     child: IconButton(
              //       icon: Icon(
              //         Icons.arrow_back_ios,
              //         size: 30,
              //       ),
              //       color: Color(0xFF8587DC),
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
