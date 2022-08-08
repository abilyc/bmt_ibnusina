import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final BuildContext parentContext;
  final GlobalKey<ScaffoldState> parentKey;
  const NavBar({Key? key, required this.parentContext, required this.parentKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        children: [
          IconButton(
              onPressed: (){
                parentKey.currentState!.openEndDrawer();
                Navigator.pushNamedAndRemoveUntil(context, 'setor', ModalRoute.withName('home'));
              },
              icon: const Icon(Icons.abc)),
          const Text('Storan'),
          const Text('Penarikan'),
          const Text('Transfer'),
        ],
      ),
    );
  }
}
