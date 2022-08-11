import 'package:bmt_ibnusina/auth/services.dart';
import 'package:flutter/cupertino.dart';
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
          UserAccountsDrawerHeader(
            accountName: Text(Auth.userData.userName, style: const TextStyle(fontWeight: FontWeight.w900)),
            accountEmail: Text('${Auth.userData.userName}@gmail.com'),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.account_circle)
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              
              
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.bag_fill_badge_plus),
            title: const Text('Penyetoran'),
            onTap: (){
              parentKey.currentState!.openEndDrawer();
              Navigator.pushNamedAndRemoveUntil(context, 'setor', ModalRoute.withName('home'));
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.bag_fill_badge_minus),
            title: const Text('Penarikan'),
            onTap: (){
              parentKey.currentState!.openEndDrawer();
              Navigator.pushNamedAndRemoveUntil(context, 'penarikan', ModalRoute.withName('home'));
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.arrow_left_right_square_fill),
            title: const Text('Transfer'),
            onTap: (){
              parentKey.currentState!.openEndDrawer();
              Navigator.pushNamedAndRemoveUntil(context, 'transfer', ModalRoute.withName('home'));
            },
          ),
        ],
      ),
    );
  }
}
