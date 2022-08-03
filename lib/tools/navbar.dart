import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orange,
      child: ListView(
        children: const [
          Text('Menu 1'),
          Text('menu 2')
        ],
      ),
    );
  }
}
