import 'package:chatty/API/api_gpt.dart';
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
    final _scrollController = ScrollController();
    final List<ChatMessage> _messages = [];
    late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: chatcolor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      var message = _messages[index];
                      return chatBubble(
                          chattext: message.text,
                          type: message.chatMessageType);
                    },
                  ))),
          Visibility(
            visible: isLoading,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
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
                      () {
                        _messages.add(
                          ChatMessage(
                            text: _textController.text,
                            chatMessageType: ChatMessageType.user,
                          ),
                        );
                        isLoading = true;
                      },
                    );
                    var input = _textController.text;
                    _textController.clear();
                    Future.delayed(const Duration(milliseconds: 50))
                        .then((_) => _scrollDown());
                    generateResponse(input).then((value) {
                      setState(() {
                        isLoading = false;
                        _messages.add(
                          ChatMessage(
                            text: value,
                            chatMessageType: ChatMessageType.bot,
                          ),
                        );
                      });
                    });
                    _textController.clear();
                    Future.delayed(const Duration(milliseconds: 50))
                        .then((_) => _scrollDown());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatBubble({required chattext, required ChatMessageType? type}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: type == ChatMessageType.bot
                ? const EdgeInsets.fromLTRB(0, 10, 16, 0)
                : const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: bgcolor,
              child: type == ChatMessageType.bot
                  ? Image.asset('asesst/44.jpg')
                  : const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 155, 151, 151),
                    ),
            )),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                color: type == ChatMessageType.bot
                    ? bgcolor
                    : Color.fromARGB(255, 254, 253, 253),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Text(
              chattext,
              style: TextStyle(
                color: type == ChatMessageType.bot ? textcolor : chatcolor,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
