import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/services/auth/login_or_register.dart';
import 'package:simple_chat_app/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder:(context, snapshot) {
          // checks if user has logged in or not
          if(snapshot.hasData) {
            return HomePage();
          }
          else {
            return const LoginOrRegister();
          }
        },),
    );
  }
}