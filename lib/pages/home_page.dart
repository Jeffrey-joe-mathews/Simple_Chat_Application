
import 'package:flutter/material.dart';
import 'package:simple_chat_app/components/my_drawer.dart';
import 'package:simple_chat_app/components/user_tile.dart';
import 'package:simple_chat_app/pages/chat_page.dart';
import 'package:simple_chat_app/services/auth/auth_service.dart';
import 'package:simple_chat_app/services/chat/chat_service.dart';


class HomePage extends StatelessWidget {
  
  HomePage({super.key});

  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const MyDrawer(
      ),
      body: _buildUserList(),
    );
  }

  // build a list of all users except the onmes that are currently logged in
  Widget _buildUserList() {
    return StreamBuilder(stream: _chatService.getUsersStream(), builder:(context, snapshot) {
      // error 
      if(snapshot.hasError) {
        return const Text("Error");
      }

      //loading
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Text("Loading...");
      }

      // return list view
      return ListView(
        children: snapshot.data!.map<Widget>((userData) => _builderUserListItem(userData, context)).toList(),
      );
    },
    );
  }

  // build individual list tile for user
  Widget _builderUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
   if(userData["email"] != _authService.getCurrentUser()!.email) {
     return UserTile(text: userData["email"], onTap:() {
      // go to chat page of the particular user
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(recieverEmail: userData["email"],),));
    });
   }
   else {
    return Container();
   }
  }

}