import 'package:bmt_ibnusina/auth/hasura.dart';
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
    void logout() {
      Hasura.headers = null;
      Auth.userData.dispose();
      Navigator.pushNamedAndRemoveUntil(context, 'login', ModalRoute.withName('home'));
    }

    return Drawer(
      backgroundColor: Colors.cyan,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(Auth.userData.userName,
                style: const TextStyle(fontWeight: FontWeight.w900)),
            accountEmail: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('${Auth.userData.userName}@gmail.com')),
                GestureDetector(
                  child: const Icon(CupertinoIcons.gear_solid,
                      size: 18, color: Colors.white),
                  onTap: () => Navigator.popAndPushNamed(context, 'myProfile'),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: logout,
                  child: const Icon(CupertinoIcons.square_arrow_left_fill,
                      size: 18, color: Colors.white),
                ),
                const SizedBox(width: 10)
              ],
            ),
            currentAccountPicture:
                const CircleAvatar(child: Icon(Icons.account_circle)),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.person_crop_circle_badge_plus),
            title: const Text('Tambah User'),
            onTap: () {
              parentKey.currentState!.openEndDrawer();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'newUser', ModalRoute.withName('home'));
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.bag_fill_badge_plus),
            title: const Text('Penyetoran'),
            onTap: () {
              parentKey.currentState!.openEndDrawer();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'setor', ModalRoute.withName('home'));
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.bag_fill_badge_minus),
            title: const Text('Penarikan'),
            onTap: () {
              parentKey.currentState!.openEndDrawer();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'penarikan', ModalRoute.withName('home'));
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.arrow_left_right_square_fill),
            title: const Text('Transfer'),
            onTap: () {
              parentKey.currentState!.openEndDrawer();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'transfer', ModalRoute.withName('home'));
            },
          ),
        ],
      ),
    );
  }
}
