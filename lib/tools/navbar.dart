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
      Navigator.pushNamedAndRemoveUntil(
          context, 'login', ModalRoute.withName('home'));
    }

    return Drawer(
      backgroundColor: Colors.cyan,
      child: Container(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(Auth.userData.userName,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
              accountEmail: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(Auth.userData.userRole)),
                  GestureDetector(
                    child: const Icon(CupertinoIcons.gear_solid,
                        size: 23, color: Colors.white),
                    onTap: () => Navigator.popAndPushNamed(context, 'myProfile'),
                  ),
                  const SizedBox(width: 10)
                ],
              ),
              currentAccountPicture:
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CircleAvatar(child: Icon(CupertinoIcons.person_alt, size: 30)),
                  ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            if (Auth.userData.userRole == 'manager')
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
            ListTile(
              leading: const Icon(CupertinoIcons.square_arrow_left_fill),
              title: const Text('Logout'),
              onTap: () {
                parentKey.currentState!.openEndDrawer();
                logout;
              },
            ),
          ],
        ),
      ),
    );
  }
}
