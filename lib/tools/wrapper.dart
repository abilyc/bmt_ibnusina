import 'package:flutter/material.dart';

import 'navbar.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key, required this.body, this.judul = 'BMT IBNU SINA', this.menu = false}) : super(key: key,);
  final Widget body;
  final String judul;
  final bool menu;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: menu,
          title: Text(judul),
          centerTitle: true,
        ),
        drawer: const NavBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child:body,
        ),
      )
    );
  }
}
