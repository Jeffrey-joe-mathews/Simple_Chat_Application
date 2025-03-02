import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/services/auth/auth.gate.dart';
import 'package:simple_chat_app/services/auth/login_or_register.dart';
import 'package:simple_chat_app/firebase_options.dart';
import 'package:simple_chat_app/pages/register_page.dart';
import 'package:simple_chat_app/themes/light_mode.dart';
import 'package:simple_chat_app/pages/login_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      // home: RegisterPage(),
      // home: LoginOrRegister(),
      home: const AuthGate(),
      theme: lightMode,
    );
  }
}