import 'package:flutter/material.dart';
import 'package:test/screens/Chats/screens/MessageListScreen.dart';
import 'package:test/screens/Chats/widgets/chatMessages.dart';
import 'package:test/screens/Chats/widgets/newMessages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Chat Screen!")),
      body: const Column(
          children: [Expanded(child: ChatMessage()), NewMessage()]),
    );
  }
}
