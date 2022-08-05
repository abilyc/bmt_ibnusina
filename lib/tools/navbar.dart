import 'package:bmt_ibnusina/screens/transaksi.dart';
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
                  MaterialPageRoute(builder: (context) => const Transaksi())),
              icon: const Icon(Icons.abc)),
          const Text('menu 2')
        ],
      ),
    );
  }
}
