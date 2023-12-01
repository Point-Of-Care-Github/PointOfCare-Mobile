// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:test/screens/Diagnosis/widgets/sample.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    const textStyle = TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(deviceSize.height * 0.09),
        child: AppBar(
          backgroundColor:
              Theme.of(context).primaryColor, // Use primarySwatch color
          leadingWidth: deviceSize.width * 0.1,
          title: Row(
            children: [
              CircleAvatar(
                radius: deviceSize.width * 0.065,
                backgroundImage: const AssetImage(
                  "./assets/images/doctor_1.jpg",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: deviceSize.width * 0.02),
                child: const Text(
                  "Dr. Doctor Name",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: deviceSize.height * 0.02,
          left: deviceSize.width * 0.02,
          right: deviceSize.width * 0.02,
          bottom: deviceSize.height * 0.16,
        ),
        children: const [
          ChatSample(),
          ChatSample(),
          ChatSample(),
          ChatSample(),
          ChatSample(),
          ChatSample(),
          ChatSample(),
        ],
      ),
      bottomSheet: Container(
        height: deviceSize.height * 0.1,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ]),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: deviceSize.width * 0.02),
              child: Icon(
                Icons.attach_file,
                size: deviceSize.width * 0.07,
                color: Colors.black54,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: deviceSize.width * 0.01),
              child: Icon(
                Icons.emoji_emotions,
                size: deviceSize.width * 0.07,
                color: Colors.amber[300],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: deviceSize.width * 0.02),
              child: Container(
                alignment: Alignment.centerRight,
                width: deviceSize.width * 0.6,
                child: TextFormField(
                  style: textStyle,
                  decoration: const InputDecoration(
                    hintText: "Type something",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: deviceSize.width * 0.02),
              child: Icon(
                Icons.send,
                size: deviceSize.width * 0.07,
                color:
                    Theme.of(context).primaryColor, // Use primarySwatch color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
