import 'package:bmt_ibnusina/auth/services.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final BuildContext parentContext;
  final GlobalKey<ScaffoldState> parentKey;
  const NavBar({Key? key, required this.parentContext, required this.parentKey})
      : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return Drawer(
  //     backgroundColor: Theme.of(context).primaryColor,
  //     child: ListView(
  //       children: [
  //         IconButton(
  //             onPressed: (){
  //               parentKey.currentState!.openEndDrawer();
  //               Navigator.pushNamedAndRemoveUntil(context, 'setor', ModalRoute.withName('home'));
  //             },
  //             icon: const Icon(Icons.abc)),
  //         const Text('Storan'),
  //         const Text('Penarikan'),
  //         const Text('Transfer'),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        children: [
          // UserAccountsDrawerHeader(
          //   accountName: const Text('Oflutter.com'),
          //   accountEmail: const Text('example@gmail.com'),
          //   currentAccountPicture: CircleAvatar(
          //     child: ClipOval(
          //       child: Image.network(
          //         'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
          //         fit: BoxFit.cover,
          //         width: 90,
          //         height: 90,
          //       ),
          //     ),
          //   ),
          //   decoration: const BoxDecoration(
          //     color: Colors.blue,
          //     image: DecorationImage(
          //       fit: BoxFit.fill,
          //       image: NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')
          //     ),
          //   ),
          // ),
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
            leading: const Icon(Icons.data_saver_on_rounded),
            title: const Text('Penyetoran'),
            onTap: (){
              parentKey.currentState!.openEndDrawer();
              Navigator.pushNamedAndRemoveUntil(context, 'setor', ModalRoute.withName('home'));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_to_home_screen_rounded),
            title: const Text('Transfer'),
            onTap: (){
              parentKey.currentState!.openEndDrawer();
              Navigator.pushNamedAndRemoveUntil(context, 'transfer', ModalRoute.withName('home'));
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_shortcut_rounded),
            title: const Text('Penarikan'),
            onTap: (){
              parentKey.currentState!.openEndDrawer();
              Navigator.pushNamedAndRemoveUntil(context, 'penarikan', ModalRoute.withName('home'));
            },
          ),
        ],
      ),
    );
  }
}
