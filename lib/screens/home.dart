import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bmt_ibnusina/auth/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isAndroid) {
      // const Size size = Size(600, 450);
      appWindow.size = const Size(600, 450);
      appWindow.maxSize = const Size(600, 450);
    }
    return Container(
      child: Text("Welcome ${Auth.userData.userName}"),
    );
  }
}
