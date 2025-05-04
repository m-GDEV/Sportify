
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:sportify/util/data_classes.dart';
import 'package:sportify/util/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final bool isEnabled;

  const ChatDetailScreen({super.key, required this.name, required this.isEnabled});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  late final List<Map<String, String>> _messages;
  void initState() {
    super.initState();
  if (!widget.isEnabled) {
    _messages = [
      {'sender': 'them', 'text': 'Hey, ready for today’s game?'},
      {'sender': 'me', 'text': 'Yeah! I’ll be there by 5.'},
    ];
  }
  else {
    _messages = [];
  }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'me', 'text': text});
      _controller.clear();
    });
  }

  void _respondToMessage(BuildContext context) async {

    var prompt = "You are an expert sports analyst. Provide detailed answers, but don't go crazy with the length. Remember you are chatting (texting) with the user. The user is trying to learn more about sports and how they can improve. You will act as their consultant and help them with anything they need to do. Make sure to respond with markdown. This is the user's information: ${dummyUser.toString()}, these are the messages so far: \n\n";
    prompt = prompt + _messages.join("\n");
    var response = await generateSummary(context, prompt);

    setState(() {
      _messages.add({'sender': 'them', 'text': response});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green[700],
                  child: Text(widget.name[0], style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[_messages.length - 1 - index];
                final isMe = msg['sender'] == 'me';
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    constraints: const BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.green[700] : Colors.grey[800],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 16),
                      ),
                    ),
                    child: SMSText(msg['text'] ?? "", isMe),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[900],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    _sendMessage();
                    if (widget.isEnabled) {
                      _respondToMessage(context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget SMSText(String text, bool isMe) {
    if (isMe) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    );

    }
    else {
      final markdownStyle = MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: const TextStyle(fontSize: 16, color: Colors.white),
        h1: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        h2: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        h3: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        h4: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        h5: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        h6: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        em: const TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        strong: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        code: const TextStyle(fontFamily: 'monospace', backgroundColor: Color(0xFF333333), color: Colors.greenAccent),
        blockquote: const TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        listBullet: const TextStyle(fontSize: 16, color: Colors.white),
      );

      return MarkdownBody(data: text, styleSheet: markdownStyle);
    }
  }
}
