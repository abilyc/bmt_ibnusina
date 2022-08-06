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
      this.back = true})
      : super(
          key: key,
        );
  final Widget body;
  final bool back;
  final String judul;
  final bool menu;

  @override
  Widget build(BuildContext context) {
    Auth.ctx(context);
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                back
                    ? IconButton(
                        iconSize: 16,
                        onPressed: () => Navigator.pop(context),
                        icon: const BackButtonIcon())
                    : const SizedBox(width: 0, height: 0),
              ],
            ),
            body,
          ],
        ),
      ),
    ));
  }
}
