import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bmt_ibnusina/tools/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            child: AppBar(
              foregroundColor: Theme.of(context).backgroundColor,
              backgroundColor: Theme.of(context).primaryColor,
              automaticallyImplyLeading: menu,
              title: Row(
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
              centerTitle: true,
            ),
          ),
          drawer: NavBar(parentContext: context, parentKey: _scaffoldKey),
          body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: menu ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const SizedBox(height: 40),
                        back
                            ? GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child:const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Icon(CupertinoIcons.arrowshape_turn_up_left_circle_fill, size: 32, color: Colors.grey,)))
                            : const SizedBox(),
                        Expanded(
                            child: Center(
                                child: Text(screen == 'login' || screen == null ? '' : screen!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15)))),
                        screen == 'PENARIKAN' ? GestureDetector(
                                onTap: () => Navigator.pushNamed(context, 'batch_penarikan'),
                                child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                        width: 29,
                                        height: 29,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(40),
                                            color: Colors.grey),
                                        child:
                                            Icon(CupertinoIcons.table_fill, size: 15, color: Theme.of(context).backgroundColor))))
                                            : const SizedBox(width: 20),
                      ],
                    ),
                  ) : const SizedBox.shrink(),
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: body
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
