import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> sendMessage(String message) async {
    setState(() {
      messages.add({"sender": "user", "text": message});
      _isLoading = true;
    });
    _controller.clear();

    // Replace with your API call
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_API_KEY'
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": message}
        ]
      }),
    );

    final data = jsonDecode(response.body);
    String reply = data['choices'][0]['message']['content'];

    setState(() {
      messages.add({"sender": "bot", "text": reply});
      _isLoading = false;
    });
  }

  Widget buildMessage(String text, String sender) {
    return Align(
      alignment: sender == "user" ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: sender == "user" ? Colors.blueAccent : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text, style: TextStyle(color: sender == "user" ? Colors.white : Colors.black)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat"),centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return buildMessage(msg["text"]!, msg["sender"]!);
              },
            ),
          ),
          if (_isLoading) CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      sendMessage(_controller.text.trim());
                    }
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
