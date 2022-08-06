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
      this.screen,
      this.menu = true,
      this.back = true})
      : super(
          key: key,
        );
  final Widget body;
  final bool back;
  final String judul;
  final bool menu;
  final String? screen;

  @override
  Widget build(BuildContext context) {
    Auth.ctx(context);
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        child: AppBar(
          automaticallyImplyLeading: menu,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Center(child: Text(judul))),
                !Platform.isAndroid ?
                SizedBox(
                  width: 55,
                  height: 55,
                  child: Padding(padding: const EdgeInsets.all(12), child: CloseWindowButton(colors: WindowButtonColors(mouseOver: Theme.of(context).primaryColorDark, mouseDown: Theme.of(context).primaryColorDark))),
                ): const SizedBox()
              ],
            ),
          ),
          centerTitle: true,
        ),
      ),
      drawer: NavBar(parentContext: context),
      body: Container(
        constraints: const BoxConstraints(maxHeight: double.infinity),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20.0),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    child: back
                        ? IconButton(
                            iconSize: 16,
                            onPressed: () => Navigator.pop(context),
                            icon: const BackButtonIcon())
                        : const SizedBox(width: 0, height: 0),
                  ),
                  Expanded(
                      child: Center(
                          child: Text(screen != null ? screen! : '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)))),
                  const SizedBox(width: 20),
                ],
              ),
              body,
            ],
          ),
        ),
      ),
    ));
  }
}
