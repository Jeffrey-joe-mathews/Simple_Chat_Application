import 'package:flutter/material.dart';
import 'package:simple_chat_app/pages/settings_page.dart';
import 'package:simple_chat_app/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    // get auth service
    final _authService = AuthService();
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //logo
          Column(
            children: [
              DrawerHeader(child: Center(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 64,
                ),
              )),
              
              //home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: () => {
                    Navigator.pop(context),
                  },
                ),
              ),
              
              //settings list tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(Icons.settings),
                  onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(context, MaterialPageRoute(builder:(context) => const SettingsPage(),)), 
                  },
                ),
              ),
            ],
          ),

          //logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: () => logout(),

            ),
          ),
          
        ],
      ),
    );
  }
}