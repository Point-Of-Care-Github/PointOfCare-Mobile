import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/doctor.dart';
import 'package:test/providers/patient.dart';
import 'package:test/screens/Chats/screens/MessageListScreen.dart';
import 'package:test/screens/Chats/widgets/chatMessages.dart';
import 'package:test/screens/Chats/widgets/newMessages.dart';

import '../../../providers/auth.dart';
import '../../../providers/radiologist.dart';

class ChatScreen extends StatelessWidget {
  final doctor;
  ChatScreen(this.doctor);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<Auth>(context, listen: false).userId;
    return Scaffold(
      appBar: AppBar(title: Text(doctor.userName)),
      body: Column(children: [
        Expanded(child: ChatMessage(userId, doctor.userId)),
        NewMessage(userId, doctor.userId)
      ]),
    );
  }
}
