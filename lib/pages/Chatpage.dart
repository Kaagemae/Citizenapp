import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> messages = [];
  TextEditingController _messageController = TextEditingController();

  // Function to send a text message
  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        messages.add({
          'text': message,
          'isReceived': false,
          'isFile': false,
        });
      });
      _messageController.clear();
    }
  }

  // Function to handle file upload
  void _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          messages.add({
            'text': filePath.split('/').last, // Display the file name
            'isReceived': false,
            'isFile': true,
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text('SA', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Swaleh Hassan', style: TextStyle(fontSize: 18)),
                Text('Active in the last 2 mins', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return _buildMessageBubble(
                  message['text'],
                  message['isReceived'],
                  message['isFile'],
                );
              },
            ),
          ),
          _buildReplySection(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildMessageBubble(String message, bool isReceived, bool isFile) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isReceived ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          decoration: BoxDecoration(
            color: isReceived ? Colors.grey[300] : Colors.blueAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: isFile
              ? Row(
            children: [
              Icon(Icons.attach_file, color: isReceived ? Colors.black : Colors.white),
              SizedBox(width: 5),
              Text(
                message,
                style: TextStyle(color: isReceived ? Colors.black : Colors.white),
              ),
            ],
          )
              : Text(
            message,
            style: TextStyle(color: isReceived ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildReplySection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Write a reply...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: _uploadFile,
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _sendMessage(_messageController.text),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          label: 'Cases',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task),
          label: 'Tasks',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        // Handle navigation
      },
    );
  }
}
