// ignore_for_file: use_key_in_widget_constructors

import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

class ChatSample extends StatelessWidget {
  const ChatSample({Key? key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: deviceSize.width * 0.4),
          child: ClipPath(
            clipper: UpperNipMessageClipper(MessageType.receive),
            child: Container(
              padding: EdgeInsets.all(deviceSize.width * 0.05),
              decoration: const BoxDecoration(
                color: Color(0xFFE1E1E2),
              ),
              child: const Text(
                "Hello!.",
                style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(
                top: deviceSize.width * 0.05, left: deviceSize.width * 0.2),
            child: ClipPath(
              clipper: LowerNipMessageClipper(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(
                    left: deviceSize.width * 0.05,
                    top: deviceSize.width * 0.025,
                    bottom: deviceSize.width * 0.08,
                    right: deviceSize.width * 0.05),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  "Hello Doctor, I need urgent help?",
                  style: TextStyle(
                      fontSize: 13, color: Colors.white, fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
