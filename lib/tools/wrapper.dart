import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bmt_ibnusina/tools/appbar.dart';
import 'package:flutter/material.dart';
import 'package:bmt_ibnusina/auth/services.dart';

import 'navbar.dart';

class Wrapper extends StatelessWidget {
  Wrapper(
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Auth(_scaffoldKey, context);
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        child: AppBar(
          foregroundColor: Theme.of(context).backgroundColor,
          automaticallyImplyLeading: menu,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                screen == 'login' ? const SizedBox(width: 55) : const SizedBox(), 
                Expanded(
                    child: Center(
                        child: Text(
                  judul,
                  style: TextStyle(
                      decorationStyle: TextDecorationStyle.solid,
                      color: Theme.of(context).backgroundColor),
                ))),
                !Platform.isAndroid
                    ? SizedBox(
                        width: 55,
                        height: 55,
                        child: GestureDetector(
                            onTap: () => appWindow.close(),
                            child: const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Icon(Icons.close_rounded, size: 15))))
                    : const SizedBox(width: 55, height: 55)
              ],
            ),
          ),
          centerTitle: true,
        ),
      ),
      drawer: NavBar(parentContext: context, parentKey: _scaffoldKey),
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
                children: [
                  back
                      ? GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.black12),
                                  child:
                                      const Icon(Icons.arrow_back, size: 15))))
                      : const SizedBox(),
                  const SizedBox(height: 40),
                  Expanded(
                      child: Center(
                          child: Text(screen == 'login' || screen == null ? '' : screen!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)))),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              body,
            ],
          ),
        ),
      ),
    ));
  }
}
