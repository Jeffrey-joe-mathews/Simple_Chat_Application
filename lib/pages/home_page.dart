
import 'package:flutter/material.dart';
import 'package:simple_chat_app/auth/auth_service.dart';
import 'package:simple_chat_app/components/my_drawer.dart';


class HomePage extends StatelessWidget {
  
  const HomePage({super.key});

  void logout(){
    // get auth service
    final _authService = AuthService();
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          // logout button
          IconButton(onPressed: logout, icon: Icon(Icons.logout))
        ],
      ),
      drawer: MyDrawer(

      ),
    );
  }
}