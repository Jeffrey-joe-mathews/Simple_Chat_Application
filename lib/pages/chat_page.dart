import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/components/my_textfield.dart';
import 'package:simple_chat_app/services/auth/auth_service.dart';
import 'package:simple_chat_app/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  final String recieverID;
  ChatPage({super.key, required this.recieverEmail, required this.recieverID});

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send message
  void sendMessage() async {
    // if anyone tries to send a message 
    if(_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(recieverID, _messageController.text);

      // clear the controller meanwhile
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverEmail),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(child: _buildMessageList(),
          ),
          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatService.getMessages(recieverID, senderID), builder:(context, snapshot) {
      // errors 
      if(snapshot.hasError) {
        return const Text("Error");
      }

      // loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text("Loading...");
      }

      // return list bview
      return ListView(
        children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
      );

    },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    print(data);
    return Text(data["message"]??"No message");
  }

  // build message input
  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(child: MyTextField(hintText: "Enter a message Here...", obscureVariable: false, controller: _messageController)),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send_outlined))
      ],
    );
  }

}