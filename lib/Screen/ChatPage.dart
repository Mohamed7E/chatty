import 'package:chatty/colors/colors.dart';
import 'package:chatty/model/Chat_model.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
    final _textController = TextEditingController();
    final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chatty",
          style: TextStyle(fontSize: 35),
        ),
        backgroundColor: Color.fromARGB(255, 55, 78, 56),
      ),
      backgroundColor: Color.fromARGB(255, 80, 81, 80),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: chatcolor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                 Expanded(
                  child: TextField(
                    controller: _textController,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    setState(
                      () {},
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
