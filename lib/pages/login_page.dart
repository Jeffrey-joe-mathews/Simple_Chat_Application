import 'package:flutter/material.dart';
import 'package:simple_chat_app/auth/auth_service.dart';
import 'package:simple_chat_app/components/my_button.dart';
import 'package:simple_chat_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {

  // email and password controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();


  final void Function()? onTap;


  LoginPage({super.key, required this.onTap});


  void login(BuildContext context) async {
    // auth service 
    final authService = AuthService();

    //try logging in
    try {
      await authService.signInWithEmailPassword(_emailController.text, _passwdController.text);
    }
    catch (e) {
      showDialog(context: context, builder:(context) => AlertDialog(
        title: Text(e.toString()),
      ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
              ),

            const SizedBox(
              height: 40,
            ),
        
            //welcome back message
            Text(
              "Hey Welcome back we missed you (^-^)",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 15.0,
              ),),

            const SizedBox(
              height: 25,
            ),
            
            //email text field
            MyTextField(hintText: "Email Address",obscureVariable: false,controller:_emailController),

            const SizedBox(height: 10,),
        
            //password field
            MyTextField(hintText: "Password", obscureVariable: true, controller:_passwdController),


            const SizedBox(height: 25,),
        
            // login button
            MyButton(text: "Login",onTap:() => login(context),),


            const SizedBox(height: 25,),
        
            // register now button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register Now", 
                    style: TextStyle(fontWeight: FontWeight.bold , color: Theme.of(context).colorScheme.primary),
                  )
                ),
              ],
            ) 
        
          ],
        ),
      ),
    );
  }
}