import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chatty",
          style: TextStyle(fontSize: 35),
        ),
        backgroundColor: Color.fromARGB(255, 55, 78, 56),
      )
      )
      ;
  }
}