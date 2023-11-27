import 'package:flutter/material.dart';
import 'package:test/screens/Diagnosis/screens/uploadScreen.dart';
import 'package:test/widgets/myButton.dart';

class SymptomsForm extends StatefulWidget {
  @override
  _SymptomsFormState createState() => _SymptomsFormState();
}

class _SymptomsFormState extends State<SymptomsForm> {
  List<String> selectedOptions = [];
  final GlobalKey<FormState> _formKey = GlobalKey();
  int? id1;
  int? id2;
  int? id3;
  int? id4;
  Map<String, String> _ans = {
    'ans1': '',
    'ans2': '',
    'ans3': '',
    'ans4': '',
    'ans5': '',
  };

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                Text(
                  'Symptoms',
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.07,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // SubHeading
                Text(
                  'Please enter patient\'s symptoms',
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.032,
                    color: Colors.black38,
                    fontFamily: 'League Spartan',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: deviceSize.height / 1.6,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '1) Which of the following best describes your chest discomfort or pain?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RadioListTile(
                            title: const Text(
                              'Sharp and stabbing',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 1,
                            groupValue: id1,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans1'] = 'Sharp and stabbing';
                                id1 = 1;
                                print(_ans['ans1']);
                              })
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                              'Dull and aching',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 2,
                            groupValue: id1,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans1'] = 'Dull and aching';
                                id1 = 2;
                                print(_ans['ans1']);
                              })
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                              'Pressure or tightness',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 3,
                            groupValue: id1,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans1'] = 'Pressure or tightness';
                                id1 = 3;
                                print(_ans['ans1']);
                              })
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                              'None of the above',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 4,
                            groupValue: id1,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans1'] = 'None of the above';
                                id1 = 4;
                                print(_ans['ans1']);
                              })
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                              'None of the above',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 5,
                            groupValue: id1,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans1'] = 'None of the above';
                                id1 = 5;
                                print(_ans['ans1']);
                              })
                            },
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '2) How long have you been experiencing chest symptoms?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RadioListTile(
                            title: const Text(
                              'Less than a day',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 1,
                            groupValue: id2,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans2'] = 'Less than a day';
                                id2 = 1;
                                print(_ans['ans2']);
                              })
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                              'A few days',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 2,
                            groupValue: id2,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans2'] = 'A few days';
                                id2 = 2;
                                print(_ans['ans2']);
                              })
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                              'A few weeks.',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 3,
                            groupValue: id2,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans1'] = 'A few weeks.';
                                id2 = 3;
                                print(_ans['ans2']);
                              })
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                              'None',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 4,
                            groupValue: id2,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans1'] = 'None';
                                id2 = 4;
                                print(_ans['ans2']);
                              })
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            '3) Are your chest symptoms associated with shortness of breath?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RadioListTile(
                            title: const Text(
                              'Yes, I have shortness of breathe.',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 1,
                            groupValue: id3,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans3'] =
                                    'Yes, I have shortness of breathe.';
                                id3 = 1;
                                print(_ans['ans3']);
                              })
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                              'Sometimes I have shortness of breathe.',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 2,
                            groupValue: id3,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans3'] =
                                    'Sometimes I have shortness of breathe.';
                                id3 = 2;
                                print(_ans['ans3']);
                              })
                            },
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '4) Are there specific activities or times of the day that seem to trigger your chest symptoms?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RadioListTile(
                            title: const Text(
                              'Yes, certain activities or times',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 1,
                            groupValue: id4,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans4'] =
                                    'Yes, certain activities or times';
                                id4 = 1;
                                print(_ans['ans4']);
                              })
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                              ' No, they occur randomly',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
                            ),
                            value: 2,
                            groupValue: id4,
                            onChanged: (value) => {
                              setState(() {
                                _ans['ans4'] = ' No, they occur randomly';
                                id4 = 2;
                                print(_ans['ans4']);
                              })
                            },
                          ),
                          const SizedBox(height: 8),
                          // Next button
                        ]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                myButton1(() {
                  if (_ans['ans1'] != '' &&
                      _ans['ans2'] != '' &&
                      _ans['ans3'] != '' &&
                      _ans['ans4'] != '') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UploadScreen(),
                      ),
                    );
                  }
                }, "Submit")
              ],
            )),
      ),
    );
  }
}
