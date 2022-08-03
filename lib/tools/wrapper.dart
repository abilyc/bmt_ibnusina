import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bmt_ibnusina/tools/appbar.dart';
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
        appBar: CustomAppBar(
          child: AppBar(
            automaticallyImplyLeading: menu,
            title: Text(judul),
            centerTitle: true,
          ),
        ),
        drawer: const NavBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8.0),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child:body,
        ),
      )
    );
  }
}
