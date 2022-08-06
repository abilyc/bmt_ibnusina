import 'package:bmt_ibnusina/screens/storan.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final BuildContext parentContext;
  const NavBar({Key? key, required this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        children: [
          IconButton(
              onPressed: () => Navigator.push(parentContext,
                  MaterialPageRoute(builder: (context) => const Penyetoran())),
              icon: const Icon(Icons.abc)),
          const Text('Storan'),
          const Text('Penarikan'),
          const Text('Transfer'),


        ],
      ),
    );
  }
}
