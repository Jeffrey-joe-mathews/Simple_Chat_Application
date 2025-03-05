import 'package:flutter/material.dart';
import 'package:simple_chat_app/services/auth/auth_service.dart';
import 'package:simple_chat_app/components/my_button.dart';
import 'package:simple_chat_app/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {



  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  final TextEditingController _confirmPasswdController = TextEditingController();
  final void Function() onTap;

   RegisterPage({super.key, required this.onTap});


   void register(BuildContext context ){
    // passwords match hence it authenticates
    if(_passwdController.text == _confirmPasswdController.text) {
      try {
        // get auth service
        final authService = AuthService();
        authService.signUpWithEmailPassword(_emailController.text, _passwdController.text);
      }
      catch (e) {
        showDialog(context: context, builder:(context) => AlertDialog(
        title: Text(e.toString()),
      ),);
      }
      
    }

    // passwords dont match
    else {
      showDialog(context: context, builder:(context) => const AlertDialog(
        icon: Icon(Icons.dangerous_outlined),
        title: Text("Passwords Don't Match"),
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
              "Let's create an account for you! ԅ(≖‿≖ԅ)",
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


            const SizedBox(height: 10,),
         

            // Confirm Password
            MyTextField(hintText: "Confirm Password", obscureVariable: true, controller:_confirmPasswdController),


            const SizedBox(height: 25,),


            // login button
            MyButton(text: "Register",onTap:() => register(context),),


            const SizedBox(height: 25,),
        
            // register now button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an Account? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login Now", style: TextStyle(fontWeight: FontWeight.bold , color: Theme.of(context).colorScheme.primary),
                  )),
              ],
            ) 
        
          ],
        ),
      ),
    );
  }
}