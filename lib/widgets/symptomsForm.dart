import 'package:flutter/material.dart';
import '../screens/uploadScreen.dart';

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
    return Container(
      constraints: BoxConstraints(minHeight: 320),
      width: deviceSize.width * 0.95,
      padding: EdgeInsets.all(deviceSize.width * 0.0427),
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: deviceSize.height * 0.135,
                          left: deviceSize.width * 0.0187,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Symptoms',
                            style: TextStyle(
                              fontSize: deviceSize.width * 0.07,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // SubHeading
                      Container(
                        margin: EdgeInsets.only(
                          bottom: deviceSize.height * 0.025,
                          top: deviceSize.height * 0.005,
                          left: deviceSize.width * 0.0187,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Please enter patient\'s symptoms',
                            style: TextStyle(
                              fontSize: deviceSize.width * 0.032,
                              color: Colors.black38,
                              fontFamily: 'League Spartan',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '1) Do you have any of the following breast changes?',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RadioListTile(
                                title: const Text(
                                  'A lump or thickening in the breast or underarm area',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 1,
                                groupValue: id1,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans1'] =
                                        'A lump or thickening in the breast or underarm area';
                                    id1 = 1;
                                    print(_ans['ans1']);
                                  })
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                  'Swelling, redness, or warmth in the breast',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 2,
                                groupValue: id1,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans1'] =
                                        'Swelling, redness, or warmth in the breast';
                                    id1 = 2;
                                    print(_ans['ans1']);
                                  })
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                  'Changes in breast size or shape',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 3,
                                groupValue: id1,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans1'] =
                                        'Changes in breast size or shape';
                                    id1 = 3;
                                    print(_ans['ans1']);
                                  })
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                  'Dimpling or puckering of the breast skin',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 4,
                                groupValue: id1,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans1'] =
                                        'Dimpling or puckering of the breast skin';
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
                                '2) Have you noticed any changes in your nipples?',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RadioListTile(
                                title: const Text(
                                  'Inversion (turning inward) of the nipples.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 1,
                                groupValue: id2,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans2'] =
                                        'Inversion (turning inward) of the nipples.';
                                    id2 = 1;
                                    print(_ans['ans2']);
                                  })
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                  'Discharge from the nipples.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 2,
                                groupValue: id2,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans2'] =
                                        'Discharge from the nipples.';
                                    id2 = 2;
                                    print(_ans['ans2']);
                                  })
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                  'A rash on the nipples.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 3,
                                groupValue: id2,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans1'] = 'A rash on the nipples.';
                                    id2 = 3;
                                    print(_ans['ans2']);
                                  })
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                  'No changes in the nipples.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 4,
                                groupValue: id2,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans1'] =
                                        'DNo changes in the nipples.';
                                    id2 = 4;
                                    print(_ans['ans2']);
                                  })
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                '3) Are you experiencing any pain or tenderness in your breast?',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RadioListTile(
                                title: const Text(
                                  'Yes, I have pain or tenderness.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 1,
                                groupValue: id3,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans3'] =
                                        'Yes, I have pain or tenderness.';
                                    id3 = 1;
                                    print(_ans['ans3']);
                                  })
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                  'No, I do not have any pain or tenderness.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 2,
                                groupValue: id3,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans3'] =
                                        'No, I do not have any pain or tenderness.';
                                    id3 = 2;
                                    print(_ans['ans3']);
                                  })
                                },
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '4) Have you noticed any enlarged lymph nodes in the underarm area?',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RadioListTile(
                                title: const Text(
                                  'Yes, I have noticed enlarged lymph nodes.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 1,
                                groupValue: id4,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans4'] =
                                        'Yes, I have noticed enlarged lymph nodes.';
                                    id4 = 1;
                                    print(_ans['ans4']);
                                  })
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                  'No, I have not noticed any enlarged lymph nodes.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                                value: 2,
                                groupValue: id4,
                                onChanged: (value) => {
                                  setState(() {
                                    _ans['ans4'] =
                                        'No, I have not noticed any enlarged lymph nodes.';
                                    id4 = 2;
                                    print(_ans['ans4']);
                                  })
                                },
                              ),
                              const SizedBox(height: 8),
                              // Next button
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {
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
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFFB9A0E6),
                                          Color(0xFF8587DC),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Container(
                                      width: deviceSize.width * 0.85,
                                      height: deviceSize.height * 0.065,
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                            fontSize: deviceSize.width * 0.048,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
