import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // side menu top image
        DrawerHeader(
          child: Container(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/menu-img.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // side menu option #1
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
        // side menu option #2
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('People'),
          onTap: () {
            //Navigator.pushReplacementNamed(context, 'settings');
          },
        ),
        // side menu option #3
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'settings');
          },
        ),
      ],
    ));
  }
}
