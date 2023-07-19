import 'package:flutter/material.dart';
import '../widgets/uploadOptions.dart';

class XrayUpload extends StatefulWidget {
  const XrayUpload({super.key});

  @override
  State<XrayUpload> createState() => _XrayUploadState();
}

class _XrayUploadState extends State<XrayUpload> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(minHeight: 320),
      width: deviceSize.width * 0.85,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Heading
            Container(
              margin: const EdgeInsets.only(top: 90, left: 7),
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'X-ray Diagnosis',
                  style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            //SubHeading
            Container(
              margin: const EdgeInsets.only(bottom: 40, top: 10, left: 7),
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Upload X-ray',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black38,
                    fontFamily: 'League Spartan',
                  ),
                ),
              ),
            ),
            UploadOptions(),
          ],
        ),
      ),
    );
  }
}
