import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bmt_ibnusina/tools/appbar.dart';
import 'package:flutter/material.dart';
import 'package:bmt_ibnusina/auth/services.dart';

import 'navbar.dart';

class Wrapper extends StatelessWidget {
  const Wrapper(
      {Key? key,
      required this.body,
      this.judul = 'BMT IBNU SINA',
      this.menu = true,
      this.size = const Size(600, 450)})
      : super(
          key: key,
        );
  final Widget body;
  final String judul;
  final Size size;
  final bool menu;

  @override
  Widget build(BuildContext context) {
    Auth.ctx(context);
    if (!Platform.isAndroid) {
      // const Size size = Size(600, 450);
      appWindow.size = size;
      appWindow.maxSize = size;
    }
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        child: AppBar(
          automaticallyImplyLeading: menu,
          title: Text(judul),
          centerTitle: true,
        ),
      ),
      drawer: NavBar(parentContext: context),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8.0),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        child: Column(
          children: [
            // Row(
            //   children: [
            //     IconButton(onPressed: () => Navigator.pop(context), icon: const BackButtonIcon())
            //   ],
            // ),
            body,
          ],
        ),
      ),
    ));
  }
}
