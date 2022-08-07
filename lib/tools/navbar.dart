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
              onPressed: () async {
                await closeDrawer();
                Navigator.pushNamed(parentKey.currentContext!, 'setor');
              },
              icon: const Icon(Icons.abc)),
          const Text('Storan'),
          const Text('Penarikan'),
          const Text('Transfer'),
        ],
      ),
    );
  }

  Future<void> closeDrawer() async {
    parentKey.currentState!.openEndDrawer();
  }
}
